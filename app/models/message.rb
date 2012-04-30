class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :phone_number_setup

  attr_accessible :received, :destination, :origin, :direction, :message_type,
                  :reply_message_id, :replied_on, :user,
                  :phone_number_setup, :reply_text
end
