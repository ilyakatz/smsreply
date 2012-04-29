class Message < ActiveRecord::Base

  attr_accessible :received, :destination, :origin, :direction, :message_type, :reply_message_id, :replied_on
end
