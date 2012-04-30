class AutoReplyJob

  def self.perform(phone_number_setup)
    phone_number_setup.away_calendars.each do |away|
      autoreply(away)
    end
  end

  private

  def self.autoreply(away_settings)
    Message.where("received >= ?", away_settings.start_at).where("received <= ?", away_settings.end_at).each do |message|
      MessageAutoReplyJob.perform(message.id, away_settings.start_at, away_settings.end_at, away_settings.message)
    end
  end

end