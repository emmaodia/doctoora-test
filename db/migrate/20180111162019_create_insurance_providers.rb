class CreateInsuranceProviders < ActiveRecord::Migration
  def change
    create_table :insurance_providers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
