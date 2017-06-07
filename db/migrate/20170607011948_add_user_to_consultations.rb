class AddUserToConsultations < ActiveRecord::Migration
  def change
    add_reference :consultations, :user, index: true, foreign_key: true
  end
end