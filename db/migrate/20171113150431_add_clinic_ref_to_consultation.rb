class AddClinicRefToConsultation < ActiveRecord::Migration
  def change
    add_reference :consultations, :clinic, index: true, foreign_key: true
  end
end
