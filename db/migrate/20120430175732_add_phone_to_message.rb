class AddPhoneToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :phone_number_setup_id, :integer
  end
end
