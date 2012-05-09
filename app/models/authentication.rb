class Authentication < ActiveRecord::Base
  attr_accessible :provider, :provider_id, :user_id

  belongs_to :user
end
