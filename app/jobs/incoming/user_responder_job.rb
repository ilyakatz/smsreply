class Incoming::UserResponderJob

  def self.perform(sender_phone, text, external_id)
    #find possible match of the message that the user is responding to
    response = ResponseMessage.where(:replied_to=>sender_phone).where("created_at > ? ", 5.days).first

    #record that there is a response to a response
    UserResponderMessage.create!(:response_message=>response,
                                 :text=>text,
                                 :external_id=>external_id)
  end

end
