class AddChiefComplaintAndAdditionalComplaintsToPatientReview < ActiveRecord::Migration
  def change
    add_column :patient_reviews, :chief_complaint, :string
    add_column :patient_reviews, :associated_complaint_1, :string
    add_column :patient_reviews, :associated_complaint_2, :string
    add_column :patient_reviews, :associated_complaint_3, :string
  end
end
