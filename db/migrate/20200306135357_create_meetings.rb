class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.references :team, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.string :name
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
