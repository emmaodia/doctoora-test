class AddDrLinkToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :dr_link, :string
  end
end
