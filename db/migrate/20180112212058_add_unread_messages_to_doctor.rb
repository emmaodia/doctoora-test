class AddUnreadMessagesToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :unread_messages, :integer, default: 0
  end
end
