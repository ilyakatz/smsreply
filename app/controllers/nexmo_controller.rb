class NexmoController <ApplicationController

  skip_before_filter :authenticate_user!

  def index
    Rails.logger.info params.inspect
    render :text=>"ok", :status=>:ok
  end

  def create
    Rails.logger.info params.inspect
    render :text=>"ok", :status=>:ok
  end

end