class Message < ActiveRecord::Base
  belongs_to :user

  attr_accessible :received, :destination, :origin, :direction, :message_type, :reply_message_id, :replied_on, :user
end
