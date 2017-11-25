class AddMultipleFieldsToPatientReview < ActiveRecord::Migration
  def change
    add_column :patient_reviews, :lga, :string
    add_column :patient_reviews, :religion, :string
    add_column :patient_reviews, :education, :string
    add_column :patient_reviews, :occupation, :string
    add_column :patient_reviews, :hpi, :text
    add_column :patient_reviews, :medical_history, :text
    add_column :patient_reviews, :surgical_history, :text
    add_column :patient_reviews, :drug_history, :text
    add_column :patient_reviews, :drug_reaction, :text
    add_column :patient_reviews, :allergic_reaction, :text
    add_column :patient_reviews, :blood_transfusions, :text
    add_column :patient_reviews, :family_history, :text
    add_column :patient_reviews, :smoking, :string
    add_column :patient_reviews, :recent_travel, :string
    add_column :patient_reviews, :travel_destination, :string
    add_column :patient_reviews, :sexual_history, :string
    add_column :patient_reviews, :religion_detailed, :string
  end
end
