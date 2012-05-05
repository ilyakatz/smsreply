class NexmoController <ApplicationController

  skip_before_filter :authenticate_user!

  def index

    params["msisdn"]
    params["to"]
    params["messageId"]
    params["text"]

    #/nexmo?
    #msisdn=19177745435&
    #to=19175215860&
    #messageId=00684813&
    #text=Ok+again%2C+how+did+you+do+that%3F&
    #type=text&
    #message-timestamp=2012-05-05+03%3A41%3A29

    Rails.logger.info params.inspect
    render :text=>"ok", :status=>:ok
  end

  def create
    Rails.logger.info params.inspect
    render :text=>"ok", :status=>:ok
  end

end