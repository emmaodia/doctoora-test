class AddInsuranceProviderToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :insurance_provider, :string, default: "placeholder field"
  end
end
