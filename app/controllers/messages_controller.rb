require 'csv'

class MessagesController < ApplicationController

  def index
    @start_date=3.days.ago
    @messages = current_user.messages.where("received > ?", @start_date)
  end

  def create

    VerizonMessagesJob.perform(current_user)
    redirect_to messages_path

  end
end