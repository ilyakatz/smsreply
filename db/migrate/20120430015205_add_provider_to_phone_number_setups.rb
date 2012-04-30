class AddProviderToPhoneNumberSetups < ActiveRecord::Migration
  def change
    add_column :phone_number_setups, :provider, :string
  end
end
