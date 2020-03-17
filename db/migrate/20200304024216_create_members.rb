class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :name
      t.boolean :owner, default: false

      t.timestamps
    end
  end
end
