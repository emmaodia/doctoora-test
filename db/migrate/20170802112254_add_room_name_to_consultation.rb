class AddRoomNameToConsultation < ActiveRecord::Migration
  def change
    add_column :consultations, :room_name, :string
  end
end
