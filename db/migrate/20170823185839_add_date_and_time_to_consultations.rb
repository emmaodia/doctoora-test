class AddDateAndTimeToConsultations < ActiveRecord::Migration
  def change
    add_column :consultations, :date_and_time, :datetime
  end
end
