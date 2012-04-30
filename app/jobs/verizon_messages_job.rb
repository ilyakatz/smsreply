class VerizonMessagesJob

  def self.perform(user)

    phone =  user.phone_number_setups.where(provider: "Verizon").first
    url = phone.url

    agent = Mechanize.new { |a|
      a.user_agent_alias = 'Mac Safari'
    }

    # get the login form & fill it out with the username/password
    login_form = agent.get(url).form('loginForm')
    login_form.IDToken1 = phone.username
    login_form.IDToken2 = phone.password


    # submit login form
    file = agent.submit(login_form, login_form.buttons.first)

    full_filename = save_verizon_data(file)


    ::CSV.foreach(full_filename, :col_sep =>"\t", :row_sep =>:auto) do |row|
      date, time, destination, origin, direction, type =row
      full_date = DateTime.strptime("#{date} #{time}", "%m/%d/%Y %H:%M %p") rescue nil

      if full_date
        m = user.messages.where(:received=>full_date).where(:destination=>destination).where(:origin=>origin)
        if m.present?
          Rails.logger.info("Message already exists")
        else
          Message.create!(:received=>full_date,
                          :destination=>destination,
                          :origin=>origin,
                          :direction=>direction,
                          :message_type=>type,
                          :user=>user)
        end
      end
    end

  end

  private

  def self.save_verizon_data(file)
    filename="ilyakatz.xls"
    full_filename="#{Rails.root}/tmp/#{filename}"

    if File.exists?(full_filename)
      File.delete(full_filename)
    end
    file.save(full_filename)
    full_filename
  end

end