class AddOnboardingAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :dob, :date
    add_column :users, :gender, :string
    add_column :users, :ethnicity, :string
    add_column :users, :house, :string
    add_column :users, :town, :string
    add_column :users, :postcode, :string
    add_column :users, :country, :string
    add_column :users, :height, :integer
    add_column :users, :weight, :integer
    add_column :users, :bmi, :integer
    add_column :users, :vaccinations, :text
  end
end
