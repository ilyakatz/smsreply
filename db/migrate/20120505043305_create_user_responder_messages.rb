class CreateUserResponderMessages < ActiveRecord::Migration
  def change
    create_table :user_responder_messages do |t|
      t.integer :response_message_id
      t.string :text
      t.text :external_id

      t.timestamps
    end
  end
end
