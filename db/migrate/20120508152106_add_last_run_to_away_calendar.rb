class AddLastRunToAwayCalendar < ActiveRecord::Migration
  def change
    add_column :away_calendars, :last_run, :datetime
  end
end
