class AddRepliedOnToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :replied_on, :datetime
    add_column :messages, :reply_message_id, :integer
  end
end
