class Providers::VerizonMessagesJob

  def self.perform(phone)
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

    full_filename = save_verizon_data(phone.id, file)


    ::CSV.foreach(full_filename, :col_sep =>"\t", :row_sep =>:auto) do |row|
      date, time, destination, origin, direction, type =row
      destination = full_phone(destination)
      origin = full_phone(origin)

      full_date = DateTime.strptime("#{date} #{time}", "%m/%d/%Y %H:%M %p") rescue nil

      if full_date
        m = phone.user.messages.where(:received=>full_date).where(:destination=>destination).where(:origin=>origin)
        if m.present?
          Rails.logger.info("Message already exists")
        else
          Message.create!(:received=>full_date,
                          :destination=>(destination),
                          :origin=>(origin),
                          :direction=>direction,
                          :message_type=>type,
                          :user=>phone.user,
                          :phone_number_setup=>phone)
        end
      end
    end

  end

  private

  def self.save_verizon_data(id, file)
    filename=%Q/#{id}.#{Time.now.strftime("%m-%d-%Y_%H:%M")}.csv/
    full_filename="#{Rails.root}/tmp/#{filename}"

    if File.exists?(full_filename)
      File.delete(full_filename)
    end

    file.save(full_filename)
    full_filename
  end

  def self.full_phone(phone)
    (phone.length == 10) ? "1#{phone}" : phone
  end

end