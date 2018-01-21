class AddBloodPressureAndRespiratoryRateToPatientReview < ActiveRecord::Migration
  def change
    add_column :patient_reviews, :blood_pressure, :string
    add_column :patient_reviews, :respiratory_rate, :integer
  end
end
