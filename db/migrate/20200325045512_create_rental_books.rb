class CreateRentalBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :rental_books do |t|
      t.references :member, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :checkout_date
      t.date :return_date
      t.integer :status

      t.timestamps
    end
  end
end
