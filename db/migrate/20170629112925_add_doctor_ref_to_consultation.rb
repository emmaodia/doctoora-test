class AddDoctorRefToConsultation < ActiveRecord::Migration
  def change
    add_reference :consultations, :doctor, index: true, foreign_key: true
  end
end
