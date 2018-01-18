class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.string :name
      t.string :dosage
      t.string :regimen
      t.string :duration

      t.timestamps null: false
    end
  end
end
