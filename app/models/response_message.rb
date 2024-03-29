#auto-response message sent by the system
class ResponseMessage < ActiveRecord::Base
  attr_accessible :external_id, :message_id, :reply_text,:replied_on, :reply_message_id, :replied_to

  belongs_to :message

  has_many :user_responder_messages
end
