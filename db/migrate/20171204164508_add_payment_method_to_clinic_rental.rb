class AddPaymentMethodToClinicRental < ActiveRecord::Migration
  def change
    add_column :clinic_rentals, :payment_method, :string
  end
end
