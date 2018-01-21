class ChangeColumnTypeInPatientReview < ActiveRecord::Migration
  def change
  	change_column(:patient_reviews, :temperature, :float)
  end
end
