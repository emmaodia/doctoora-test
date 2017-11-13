class ChangeDataTypeForNumberInClinic < ActiveRecord::Migration
  def change
  	change_table :clinics do |t|
      t.change :phone, :string
    end
  end
end
