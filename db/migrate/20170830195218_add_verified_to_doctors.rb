class AddVerifiedToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :verified, :boolean
  end
end
