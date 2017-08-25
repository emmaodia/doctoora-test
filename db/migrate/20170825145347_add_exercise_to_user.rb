class AddExerciseToUser < ActiveRecord::Migration
  def change
    add_column :users, :exercise, :string
  end
end
