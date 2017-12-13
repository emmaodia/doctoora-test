class AddUserNotesToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :user_notes, :text
  end
end
