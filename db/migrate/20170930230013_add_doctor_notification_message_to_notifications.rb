class AddDoctorNotificationMessageToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :dr_notification_msg, :string
  end
end
