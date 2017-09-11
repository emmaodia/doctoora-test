class CreateCareTeamDoctorStatuses < ActiveRecord::Migration
  def change
    create_table :care_team_doctor_statuses do |t|
      t.references :care_team, index: true, foreign_key: true
      t.references :doctor, index: true, foreign_key: true
      t.boolean :joined

      t.timestamps null: false
    end
  end
end
