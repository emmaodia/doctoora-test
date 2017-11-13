class AddTownToClinic < ActiveRecord::Migration
  def change
    add_column :clinics, :town, :string
  end
end
