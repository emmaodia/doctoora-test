class AddTieredConsultationFeesToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :home_consultation_fee, :integer, default: 0
    add_column :doctors, :clinic_consultation_fee, :integer, default: 0
    add_column :doctors, :video_consultation_fee, :integer, default: 0
  end
end
