class AddStatusToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :status, :string
  end
end
