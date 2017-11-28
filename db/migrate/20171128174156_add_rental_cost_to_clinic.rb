class AddRentalCostToClinic < ActiveRecord::Migration
  def change
    add_column :clinics, :rental_cost, :integer, default: 0
  end
end
