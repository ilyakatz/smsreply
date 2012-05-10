require 'csv'

class MessagesController < ApplicationController

  def index
    redirect_to messages_received_path
  end

  def received
    @messages = current_user.messages.order("received DESC").where(:direction=>"Received").page(params[:page])
  end

  def sent
    @messages = current_user.messages.order("received DESC").where(:direction=>"Sent").page(params[:page])
  end

  def show
    @message = current_user.messages.find(params[:id])
  end

  def create

    current_user.phone_number_setups.where(provider_id: Provider.find_by_name(Provider::VERIZON)).each do |phone|
      Providers::VerizonMessagesJob.perform(phone.id)
    end

    redirect_to messages_path

  end
end