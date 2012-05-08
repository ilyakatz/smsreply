class Cron::SendAutorepliesJob < TheJob

  @queue = :cron

  def self.perform
    AwayCalendar.current.each do |away_calendar|
      Resque.enqueue(AutoReplyJob, away_calendar.id)
    end
  end

end