class AddSystolicAndDiastolicToPatientReview < ActiveRecord::Migration
  def change
    add_column :patient_reviews, :systolic, :integer
    add_column :patient_reviews, :diastolic, :integer
  end
end
