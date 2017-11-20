class AddSenderClassAndRecipientClassToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :sender_class, :string
    add_column :conversations, :recipient_class, :string, default: "Patient"
  end
end
