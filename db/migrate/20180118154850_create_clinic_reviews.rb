class CreateClinicReviews < ActiveRecord::Migration
  def change
    create_table :clinic_reviews do |t|
      t.integer :cleanliness
      t.integer :customer_service
      t.integer :noise_level
      t.integer :comfort
      t.integer :overall
      t.references :clinic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
