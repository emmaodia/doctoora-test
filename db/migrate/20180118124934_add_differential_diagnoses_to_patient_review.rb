class AddDifferentialDiagnosesToPatientReview < ActiveRecord::Migration
  def change
    add_column :patient_reviews, :differential_diagnosis_2, :string
    add_column :patient_reviews, :differential_diagnosis_3, :string
    add_column :patient_reviews, :differential_diagnosis_4, :string
    add_column :patient_reviews, :differential_diagnosis_5, :string
  end
end
