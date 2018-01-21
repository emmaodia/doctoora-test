class RemovePrescriptionColumnFromPatientReview < ActiveRecord::Migration
  def change
  	remove_column(:patient_reviews, :prescription_name)
  	remove_column(:patient_reviews, :prescription_dosage)
  	remove_column(:patient_reviews, :prescription_regimen)
  	remove_column(:patient_reviews, :prescription_duration)
  end
end