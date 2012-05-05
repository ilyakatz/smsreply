class RemoveAutoreplyAttributesFromMessage < ActiveRecord::Migration
  def up
    remove_column :messages, :reply_text
    remove_column :messages, :message_id
    remove_column :messages, :replied_on
    remove_column :messages, :reply_message_id
  end

  def down
    add_column :messages, :reply_text, :string
    add_column :messages, :message_id, :integer
    add_column :messages, :replied_on, :datetime
    add_column :messages, :reply_message_id, :integer
  end


end
