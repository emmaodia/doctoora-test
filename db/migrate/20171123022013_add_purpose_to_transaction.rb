class AddPurposeToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :purpose, :string
  end
end
