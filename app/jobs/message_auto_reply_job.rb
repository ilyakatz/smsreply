class MessageAutoReplyJob

  def self.perform(message_id, start_at, end_at, reply_text)

    message = Message.find(message_id)

    if message.replied_on
      return
    end

    replied = Message.where(:origin=>message.origin).
        where(:destination=>message.destination).
        where("replied_on is not null").
        where("received >= ?", start_at).
        where("received <= ?", end_at)

    if replied.present?
      message.update_attributes(:reply_message_id=>replied.first.id, :replied_on=>replied.first.replied_on) unless message.replied_on
    else
      if message.direction == "Received"
        message.replied_on=Time.now
        message.reply_text =reply_text
        message.save!
      end

    end

  end

end