class AddInsuranceProviderToClinicRental < ActiveRecord::Migration
  def change
    add_column :clinic_rentals, :insurance_provider, :string
  end
end
