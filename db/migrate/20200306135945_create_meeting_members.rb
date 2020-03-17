class CreateMeetingMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :meeting_members do |t|
      t.references :member, null: false, foreign_key: true
      t.references :meeting, null: false, foreign_key: true
      t.boolean :organizer

      t.timestamps
    end
  end
end
