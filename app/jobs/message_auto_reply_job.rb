class MessageAutoReplyJob

  def self.perform(message, date)
    replied = Message.where(:origin=>message.origin).
        where(:destination=>message.destination).
        where("replied_on is not null").
        where("received > ?", date)

    if replied.present?
      message.update_attributes(:reply_message_id=>replied.first.id, :replied_on=>replied.first.replied_on) unless message.replied_on
    else
      if message.direction == "Received"
        message.replied_on=Time.now
        message.save!
      end

    end

  end

end