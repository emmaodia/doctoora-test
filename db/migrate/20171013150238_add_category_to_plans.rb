class AddCategoryToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :category, :string
  end
end
