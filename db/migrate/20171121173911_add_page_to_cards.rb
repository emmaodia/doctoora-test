class AddPageToCards < ActiveRecord::Migration
  def change
    add_column :cards, :page, :string
  end
end
