class PhoneNumberSetup < ActiveRecord::Base
  attr_accessible :password, :url, :user_id, :username, :provider

  belongs_to :user
  has_many :away_calendars
end
