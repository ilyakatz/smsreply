class AutoReplyJob

  def self.perform(date)
    Message.where("received > ?", date).each do |message|
      MessageAutoReplyJob.perform(message, date)
    end
  end

end