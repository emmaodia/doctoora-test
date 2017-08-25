class CreateCareTeams < ActiveRecord::Migration
  def change
    create_table :care_teams do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :doctor_ids, array: true, default: []

      t.timestamps null: false
    end
  end
end
