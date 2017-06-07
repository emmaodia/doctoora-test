class CreateConsultations < ActiveRecord::Migration
  def change
    create_table :consultations do |t|
      t.string :discipline
      t.string :service
      t.string :tool
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :professional

      t.timestamps null: false
    end
  end
end
