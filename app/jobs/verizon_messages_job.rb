class VerizonMessagesJob

  def self.perform(url)
    agent = Mechanize.new { |a|
      a.user_agent_alias = 'Mac Safari'
    }

    # get the login form & fill it out with the username/password
    login_form = agent.get(url).form('loginForm')
    login_form.IDToken1 = 'ilyakatz'
    login_form.IDToken2 = 'vobla123'


    # submit login form
    file = agent.submit(login_form, login_form.buttons.first)
    file
  end

end