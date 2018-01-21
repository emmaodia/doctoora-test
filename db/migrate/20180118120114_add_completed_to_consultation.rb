class AddCompletedToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :completed, :boolean, default: false
  end
end
