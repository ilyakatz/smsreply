class AwayCalendar < ActiveRecord::Base
  attr_accessible :end_at, :message, :phone_number_setup_id, :start_at, :last_run

  scope :current, where("start_at <= ? ", Time.now).where("end_at >= ?", Time.now)

  validates_presence_of :end_at
  validates_presence_of :start_at
  validates_presence_of :message

  belongs_to :phone_number_setup
  has_many :messages, :through=>:phone_number_setup

  #TODO: make sure there are no overlappings
end
