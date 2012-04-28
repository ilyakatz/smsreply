class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.datetime :received
      t.string :destination
      t.string :origin
      t.string :direction
      t.string :message_type

      t.timestamps
    end

    add_index :messages, [:destination, :origin, :received], :unique => true
  end

  def self.down
    drop_table :messages
  end
end
