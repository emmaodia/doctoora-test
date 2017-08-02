class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :doctor, index: true, foreign_key: true
      t.text :notification

      t.timestamps null: false
    end
  end
end
