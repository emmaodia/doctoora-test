class AddAdditionalInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :conditions, :text
    add_column :users, :dietary_restrictions, :string
    add_column :users, :alcohol_consumption, :string
    add_column :users, :recreational_drug, :string
    add_column :users, :tobacco, :string
    add_column :users, :sexual_activity, :string
  end
end
