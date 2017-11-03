class AddSenderUnreadMessagesToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :sender_unread_messages, :boolean, default: true
  end
end
