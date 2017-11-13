class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :link
      t.text :body

      t.timestamps null: false
    end
  end
end
