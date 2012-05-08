class RepliesController < ApplicationController

  def index
    send_auto_replies
    redirect_to messages_path
  end

  private

  def send_auto_replies
    current_user.away_calendars.each do |away|
      Resque.enqueue(AutoReplyJob,away.id)
    end
  end

end