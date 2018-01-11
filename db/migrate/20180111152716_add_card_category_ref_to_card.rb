class AddCardCategoryRefToCard < ActiveRecord::Migration
  def change
    add_reference :cards, :card_category, index: true, foreign_key: true
  end
end
