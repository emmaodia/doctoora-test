class AddInsuranceProviderRefToTransaction < ActiveRecord::Migration
  def change
    add_reference :transactions, :insurance_provider, index: true, foreign_key: true
  end
end
