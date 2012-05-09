class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, #, :validatable
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :messages
  has_many :phone_number_setups
  has_many :away_calendars, :through => :phone_number_setups

  has_many :authentications

  def self.add_facebook_credentials(access_token)
    unless facebook_connected?
      data = access_token.extra.raw_info
      if Authentication.find_by_provider_and_provider_id("facebook", data["id"])
        return false
      else
        self.connect "facebook", data["id"]
      end
    end
  end

  def facebook_connected?
    self.authentications.where(provider: "facebook").exists?
  end

  def connect(provider, provider_id)
    unless send "#{provider}_connected?"
      Authentication.create! provider: provider, provider_id: provider_id, user_id: self.id
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info

    #if you've connected with facebook before
    if login = Authentication.find_by_provider_id(data["id"]).try(:user)
      login
      #if you've connected with regular email before
      #and now want to connect your email account
    elsif login = User.find_by_email(data["email"])
      login.connect "facebook", data["id"]
      login
    else # Create a user with a stub password.
      login = User.new(
          email: data["email"],
          password: Devise.friendly_token[0, 20])
      login.save!
      login.connect "facebook", data["id"]
      login
    end
  end


end
