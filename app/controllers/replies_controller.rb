class RepliesController < ApplicationController

  def index
    send_auto_replies
    redirect_to messages_path
  end

  private

  def send_auto_replies
    AutoReplyJob.perform(2.days.ago)
  end

end