class RemoveRedundantColumnsFromDoctor < ActiveRecord::Migration
  def change
  	remove_column(:doctors, :clinic_consultation_fee)
  	remove_column(:doctors, :consultation_fee)
  end
end
