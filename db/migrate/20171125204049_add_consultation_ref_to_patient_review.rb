class AddConsultationRefToPatientReview < ActiveRecord::Migration
  def change
    add_reference :patient_reviews, :consultation, index: true, foreign_key: true
  end
end
