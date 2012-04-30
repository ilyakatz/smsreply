class RepliesController < ApplicationController

  def index
    send_auto_replies
    redirect_to messages_path
  end

  private

  def send_auto_replies
    AutoReplyJob.perform(current_user.phone_number_setups.first)
  end

end