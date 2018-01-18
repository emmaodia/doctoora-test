class AddPatientReviewConsultationUserAndDoctorReferencesToPrescription < ActiveRecord::Migration
  def change
    add_reference :prescriptions, :patient_review, index: true, foreign_key: true
    add_reference :prescriptions, :consultation, index: true, foreign_key: true
    add_reference :prescriptions, :user, index: true, foreign_key: true
    add_reference :prescriptions, :doctor, index: true, foreign_key: true
  end
end
