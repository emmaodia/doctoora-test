class AddConsultationIdToDoctorReview < ActiveRecord::Migration
  def change
    add_reference :doctor_reviews, :consultation, index: true, foreign_key: true
  end
end
