require 'csv'

class MessagesController < ApplicationController

  def index
    @messages = current_user.messages.order("received DESC")
  end

  def create

    VerizonMessagesJob.perform(current_user)
    redirect_to messages_path

  end
end