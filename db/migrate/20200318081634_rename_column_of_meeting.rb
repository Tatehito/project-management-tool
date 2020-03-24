class RenameColumnOfMeeting < ActiveRecord::Migration[6.0]
  def change
    rename_column :meetings, :start, :start_time
    rename_column :meetings, :end, :end_time
  end
end
