class ChangeDatatypeMeeting < ActiveRecord::Migration[6.0]
  def change
    change_column :meetings, :start, :datetime
    change_column :meetings, :end, :datetime
  end
end
