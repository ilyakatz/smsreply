class MessageAutoReplyJob

  def self.perform(message_id, start_at, end_at, reply_text)

    message = Message.find(message_id)

    if message.replied_on
      return
    end

    #TODO: last day is not included
    replied = Message.where(:origin=>message.origin).
        where(:destination=>message.destination).
        where("replied_on is not null").
        where("received >= ?", start_at).
        where("received <= ?", end_at)

    if replied.present?
      message.update_attributes(:reply_message_id=>replied.first.id, :replied_on=>replied.first.replied_on) unless message.replied_on
    else
      if message.direction == "Received"
        send_message(message, reply_text, message.origin)
      end

    end

  end

  private

  def self.send_message(message, reply_text, send_to)

    #TODO: refactor to move the hardcoded stuff
    if ENV['SEND_MESSAGE'] or Rails.env.production?
      Rails.logger.info("send_message: Sending message to #{send_to}: #{reply_text}")
      nexmo = Nexmo::Client.new("1ba7bd6b", "eea6251d")

      response = nexmo.send_message({
                                        from: '19175215860',
                                        to: send_to,
                                        text: reply_text
                                    })
      if response.success?
        success = true
      elsif response.failure?
        raise "Unable to send message to #{send_to}"
      end
    else
      Rails.logger.info("send_message: MOCK Sending message to #{send_to}: #{reply_text}")
      success = true
    end

    if success
      message.replied_on=Time.now
      message.reply_text =reply_text
      message.message_id = response.message_id if response and response.message_id
      message.save!
    end

  end

end