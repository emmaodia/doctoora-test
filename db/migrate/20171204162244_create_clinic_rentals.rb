class CreateClinicRentals < ActiveRecord::Migration
  def change
    create_table :clinic_rentals do |t|
      t.references :clinic, index: true, foreign_key: true
      t.references :transaction, index: true, foreign_key: true
      t.date :date
      t.time :time
      t.datetime :date_and_time

      t.timestamps null: false
    end
  end
end
