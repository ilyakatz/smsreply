class Message < ActiveRecord::Base

  attr_accessible :received, :destination, :origin, :direction, :message_type
end
