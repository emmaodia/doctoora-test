class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :allergies, :text
    add_column :users, :medication, :text
    add_column :users, :lasting_conditions, :text
  end
end
