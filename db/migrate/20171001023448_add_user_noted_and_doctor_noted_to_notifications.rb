class AddUserNotedAndDoctorNotedToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :user_noted, :boolean
    add_column :notifications, :doctor_noted, :boolean
  end
end
