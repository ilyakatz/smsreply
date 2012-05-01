# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(email: "ilyakatz@gmail.com", password: "secret123")
verizon = Provider.create(name: "Verizon")
u.phone_number_setups << PhoneNumberSetup.create(username: "ilyakatz", password: "vobla123", provider_id: verizon.id, url: "https://nbillpay.verizonwireless.com/vzw/accountholder/unbilledusage/UnbilledMessaging.action?d-4019015-e=2&6578706f7274=1&mtn=9177745435&tab=messages")

