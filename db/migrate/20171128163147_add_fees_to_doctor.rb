class AddFeesToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :registration_fee, :integer
    add_column :doctors, :consultation_fee, :integer
    add_column :doctors, :clinic_visit_fee, :integer
  end
end
