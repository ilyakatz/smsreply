class CreateAwayCalendars < ActiveRecord::Migration
  def change
    create_table :away_calendars do |t|
      t.integer :phone_number_setup_id
      t.datetime :start_at
      t.datetime :end_at
      t.string :message

      t.timestamps
    end
  end
end
