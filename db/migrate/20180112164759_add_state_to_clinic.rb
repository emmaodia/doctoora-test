class AddStateToClinic < ActiveRecord::Migration
  def change
    add_column :clinics, :state, :string
  end
end
