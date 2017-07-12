class AddDoctorRefToPatientReviews < ActiveRecord::Migration
  def change
    add_reference :patient_reviews, :doctor, index: true, foreign_key: true
  end
end
