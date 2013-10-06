class AddScoreToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :score, :string
  end
end
