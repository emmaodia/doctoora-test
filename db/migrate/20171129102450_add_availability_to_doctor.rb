class AddAvailabilityToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :available, :boolean, default: true
  end
end
