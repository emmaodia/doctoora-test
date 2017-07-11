class CreatePatientReviews < ActiveRecord::Migration
  def change
    create_table :patient_reviews do |t|
      t.text :review
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
