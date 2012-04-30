class CreatePhoneNumberSetups < ActiveRecord::Migration
  def change
    create_table :phone_number_setups do |t|
      t.integer :user_id
      t.string :username
      t.string :password
      t.string :url

      t.timestamps
    end
  end
end
