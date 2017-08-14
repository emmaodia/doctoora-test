class AddAddressToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :address, :text
  end
end
