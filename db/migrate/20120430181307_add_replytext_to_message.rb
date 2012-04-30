class AddReplytextToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :reply_text, :string
  end
end
