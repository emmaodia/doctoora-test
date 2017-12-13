class AddAlcoholConsumptionToPatientReview < ActiveRecord::Migration
  def change
    add_column :patient_reviews, :alcohol_consumption, :string
  end
end
