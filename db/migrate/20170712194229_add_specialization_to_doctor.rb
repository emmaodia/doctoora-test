class AddSpecializationToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :specialization, :string
  end
end
