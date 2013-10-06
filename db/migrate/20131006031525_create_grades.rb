class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :mode
      t.integer :value
      t.datetime :finish_date
      t.references :assignment, index: true
      t.references :student, index: true

      t.timestamps
    end
  end
end
