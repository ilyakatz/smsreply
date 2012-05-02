class ChangeIndexForMessages < ActiveRecord::Migration
  def up
    remove_index :messages, [:destination, :origin, :received]
    add_index :messages, [:destination, :origin, :received, :direction], :unique => true, :name => 'index_unique_index'
  end

  def down
    remove_index :messages, :name => 'index_unique_index'
    add_index :messages, [:destination, :origin, :received], :unique => true
  end
end
