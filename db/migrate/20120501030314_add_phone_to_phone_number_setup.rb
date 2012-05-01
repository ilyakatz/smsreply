class AddPhoneToPhoneNumberSetup < ActiveRecord::Migration
  def change
    add_column :phone_number_setups, :phone, :string
  end
end
