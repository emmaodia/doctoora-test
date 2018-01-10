class CreateAdminNotifications < ActiveRecord::Migration
  def change
    create_table :admin_notifications do |t|
      t.text :notification_text
      t.string :user_class
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
