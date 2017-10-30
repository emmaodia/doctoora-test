class AddUnreadMessagesToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :unread_messages, :boolean, default: true
  end
end
