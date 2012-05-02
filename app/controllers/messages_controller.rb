require 'csv'

class MessagesController < ApplicationController

  def index
    @received_messages = current_user.messages.order("received DESC").where(:direction=>"Received")
    @sent_messages = current_user.messages.order("received DESC").where(:direction=>"Sent")
  end

  def create

    current_user.phone_number_setups.where(provider_id: Provider.find_by_name(Provider::VERIZON)).each do |phone|
      Providers::VerizonMessagesJob.perform(phone)
    end

    redirect_to messages_path

  end
end