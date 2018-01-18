class AddVideoUrlToCard < ActiveRecord::Migration
  def change
    add_column :cards, :video_url, :string
  end
end
