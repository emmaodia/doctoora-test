class ChangeBooleanDefaultValuesForConversation < ActiveRecord::Migration
  def change
  	change_column :conversations, :unread_messages, :boolean, default: false
  	change_column :conversations, :sender_unread_messages, :boolean, default: false
  end
end
