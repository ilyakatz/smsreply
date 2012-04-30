class AwayCalendar < ActiveRecord::Base
  attr_accessible :end_at, :message, :phone_number_setup_id, :start_at

  belongs_to :phone_number_setup
end
