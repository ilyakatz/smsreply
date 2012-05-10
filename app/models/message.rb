class Message < ActiveRecord::Base

  paginates_per 25

  belongs_to :user
  belongs_to :phone_number_setup

  has_many :response_messages

  has_many :user_responder_messages, :through => :response_messages

  attr_accessible :received, :destination, :origin, :direction, :message_type,
                  :reply_message_id, :replied_on, :user,
                  :phone_number_setup, :reply_text

  def clear_autoreply!
    update_attributes(:replied_on=>nil,
                      :reply_message_id=>nil,
                      :reply_text=>nil)
  end

  def reply_text
    response_messages.try(:first).try(:reply_text)
  end

  def message_id
    response_messages.try(:first).try(:message_id)
  end

  def replied_on
    response_messages.try(:first).try(:replied_on)
  end

  def reply_message_id
    response_messages.try(:first).try(:reply_message_id)
  end

end
