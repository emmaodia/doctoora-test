class ChangeStartTimeToTime < ActiveRecord::Migration
  def change
  	rename_column :consultations, :start_time, :time
  end
end
