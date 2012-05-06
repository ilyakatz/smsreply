class ApplicationController < ActionController::Base
  protect_from_forgery

  include MobilePath

  layout :set_layout

  #for the first version we want to only show mobile version
  def mobile_browser?
    true
  end

  def set_layout
    if mobile_request?
      "mobile"
    else
      "application"
    end
  end

  before_filter :authenticate_user!
end
