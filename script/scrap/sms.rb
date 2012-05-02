require 'nexmo'

nexmo = Nexmo::Client.new("1ba7bd6b", "eea6251d")

response = nexmo.send_message({
                                  from: '19175215860',
                                  to: '19177745435',
                                  text: "Autoreply for Ilya Katz: I will be unavailable until Jun 09,2012. Please email me"
                              })

if response.success?
  puts "success"
elsif response.failure?
  puts response.error
end


http ://rest.nexmo.com/sms/json? username=ilyakatz @gmail.com&password=youinexmo&from=MyCompany20&to=9177745435


http ://basicstate.com/htm/page.htm


###########
require 'mechanize'


# create Mechanize instance
agent = Mechanize.new { |a|
  a.user_agent_alias = 'Mac Safari'
}
# get the login form & fill it out with the username/password
vzlink = "https://nbillpay.verizonwireless.com/vzw/accountholder/unbilledusage/UnbilledMessaging.action?d-4019015-e=2&6578706f7274=1&mtn=9177745435&tab=messages"
login_form = agent.get(vzlink).form('loginForm')
login_form.IDToken1 = 'ilyakatz'
login_form.IDToken2 = 'asdf'

# submit login form
file = agent.submit(login_form, login_form.buttons.first)

# overide the file

filename="ilyakatz.xls"
full_filename="#{Rails.root}/tmp/#{filename}"

if File.exists?(full_filename)
  File.delete(full_filename)
end
file.save(full_filename)

require 'csv'

start_date=3.days.ago

puts "All messages from #{start_date.to_date}"

CSV.foreach(full_filename, :col_sep =>"\t", :row_sep =>:auto) do |row|
  date, time, destination, origin, direction, type =row
  full_date = DateTime.strptime("#{date} #{time}", "%m/%d/%Y %H:%M %p") rescue nil
  if full_date and full_date > start_date
    puts " #{full_date} - #{destination} - #{origin} - #{direction} - #{type} "
    puts "-----"
  end
end


DateTime.strptime("04/22/2012 9:45 AM", "%m/%d/%Y %H:%M")