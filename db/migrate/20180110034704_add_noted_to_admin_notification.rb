class AddNotedToAdminNotification < ActiveRecord::Migration
  def change
    add_column :admin_notifications, :noted, :boolean, default: false
  end
end
