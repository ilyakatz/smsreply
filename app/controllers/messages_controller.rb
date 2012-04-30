require 'csv'

class MessagesController < ApplicationController

  def index
    @received_messages = current_user.messages.order("received DESC").where(:direction=>"Received")
    @sent_messages = current_user.messages.order("received DESC").where(:direction=>"Sent")
  end

  def create

    VerizonMessagesJob.perform(current_user)
    redirect_to messages_path

  end
end