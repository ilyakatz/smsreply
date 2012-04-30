require 'csv'

class MessagesController < ApplicationController

  def index
    @messages = current_user.messages
  end

  def create

    VerizonMessagesJob.perform(current_user)
    redirect_to messages_path

  end
end