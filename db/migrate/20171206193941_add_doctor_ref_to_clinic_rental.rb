class AddDoctorRefToClinicRental < ActiveRecord::Migration
  def change
    add_reference :clinic_rentals, :doctor, index: true, foreign_key: true
  end
end
