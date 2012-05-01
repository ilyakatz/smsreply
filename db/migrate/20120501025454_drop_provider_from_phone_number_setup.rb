class DropProviderFromPhoneNumberSetup < ActiveRecord::Migration
  def up
    remove_column :phone_number_setups, :provider
    add_column :phone_number_setups, :provider_id, :integer
  end

  def down
    add_column :phone_number_setups, :provider, :string
    remove_column :phone_number_setups, :provider_id
  end
end
