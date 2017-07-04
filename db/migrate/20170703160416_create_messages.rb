class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, index: true, foreign_key: true
      t.references :messageable, polymorphic: true, index: true
      t.boolean :read

      t.timestamps null: false
    end
  end
end
