class PhoneNumberSetup < ActiveRecord::Base
  attr_accessible :password, :url, :user_id, :username, :provider_id, :phone

  belongs_to :user
  has_many :away_calendars

  belongs_to :provider

  validates_presence_of :password, :username, :provider, :phone
  validates_uniqueness_of :phone

  before_save :validate_with_provider

  private

  def validate_with_provider

    if provider.name == "Verizon"
      self.url = "https://nbillpay.verizonwireless.com/vzw/accountholder/unbilledusage/UnbilledMessaging.action?d-4019015-e=2&6578706f7274=1&mtn=#{phone}&tab=messages"
      return validate_verizon
    else
      self.errors.add :provider, "Invalid provider"
      return false
    end

  end

  def validate_verizon

    # create Mechanize instance
    agent = Mechanize.new { |a|
      a.user_agent_alias = 'Mac Safari'
    }

    # get the login form & fill it out with the username/password
    login_form = agent.get(self.url).form('loginForm')
    login_form.IDToken1 = self.username
    login_form.IDToken2 = self.password

    # submit login form
    res = agent.submit(login_form, login_form.buttons.first)

    #if we succeed, a file will be returned, not a page
    if res.class == Mechanize::Page and res.try(:title) =~ /Sign In/
      self.errors.add :provider, "Unable to connect to 'Verizon Wireless'. Please check the information provided"
      return false
    elsif res.class == Mechanize::File
      return true
    end

    self.errors.add :provider, "Unable to verify provider. Please contact support"
    false

  end
end
