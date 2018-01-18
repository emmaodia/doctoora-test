class CreateDoctorReviews < ActiveRecord::Migration
  def change
    create_table :doctor_reviews do |t|
      t.date :date
      t.integer :explanation_clarity
      t.integer :courtesy
      t.integer :listening
      t.integer :punctuality
      t.integer :overall
      t.references :doctor, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
