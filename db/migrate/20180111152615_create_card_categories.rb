class CreateCardCategories < ActiveRecord::Migration
  def change
    create_table :card_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
