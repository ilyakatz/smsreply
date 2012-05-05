class CreateResponseMessages < ActiveRecord::Migration
  def change
    create_table :response_messages do |t|
      t.integer :message_id
      t.string :external_id
      t.text :reply_text
      t.datetime :replied_on
      t.integer :reply_message_id
      t.string :replied_to

      t.timestamps
    end
  end
end
