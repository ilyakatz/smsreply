#messages sent by user in reponse to auto responder
class UserResponderMessage < ActiveRecord::Base
  attr_accessible :external_id, :response_message_id, :text, :response_message

  belongs_to :response_message
end
