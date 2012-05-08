class AutoReplyJob < TheJob

  @queue = :replies

  def self.perform(away_settings_id)
    away_calendar = AwayCalendar.find(away_settings_id)
    scope = away_calendar.messages.where("received >= ?", away_calendar.start_at).
        where("received <= ?", away_calendar.end_at)
    scope = scope.where("messages.created_at >= ?", away_calendar.last_run) if away_calendar.last_run
    scope.each do |message|
      Rails.logger.debug("Enqueuing #{message.id}")
      Resque.enqueue(MessageAutoReplyJob, message.id, away_calendar.start_at, away_calendar.end_at, away_calendar.message)
    end

    away_calendar.last_run = Time.now
    away_calendar.save!
  end

end