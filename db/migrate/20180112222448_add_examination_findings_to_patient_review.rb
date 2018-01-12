class AddExaminationFindingsToPatientReview < ActiveRecord::Migration
  def change
    add_column :patient_reviews, :temperature, :integer
    add_column :patient_reviews, :pulse_rate, :integer
    add_column :patient_reviews, :physical_exam, :text
    add_column :patient_reviews, :mental_exam, :text
    add_column :patient_reviews, :problems_list, :text
    add_column :patient_reviews, :differential_diagnosis, :string
    add_column :patient_reviews, :investigations, :string
    add_column :patient_reviews, :final_diagnosis, :string
    add_column :patient_reviews, :comment, :text
    add_column :patient_reviews, :prescription_name, :string
    add_column :patient_reviews, :prescription_dosage, :string
    add_column :patient_reviews, :prescription_regimen, :string
    add_column :patient_reviews, :prescription_duration, :string
  end
end
