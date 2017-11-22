class AddPaymentMethodToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :payment_method, :string
  end
end
