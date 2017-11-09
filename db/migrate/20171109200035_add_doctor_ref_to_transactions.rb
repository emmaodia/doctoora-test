class AddDoctorRefToTransactions < ActiveRecord::Migration
  def change
    add_reference :transactions, :doctor, index: true, foreign_key: true
  end
end
