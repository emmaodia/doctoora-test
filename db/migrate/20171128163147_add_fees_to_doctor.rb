class AddFeesToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :registration_fee, :integer, default: 0
    add_column :doctors, :consultation_fee, :integer, default: 0
    add_column :doctors, :clinic_visit_fee, :integer, default: 0
  end
end
