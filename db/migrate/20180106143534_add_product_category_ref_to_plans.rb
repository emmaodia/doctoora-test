class AddProductCategoryRefToPlans < ActiveRecord::Migration
  def change
    add_reference :plans, :product_category, index: true, foreign_key: true
  end
end
