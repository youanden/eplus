class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.integer :value
      t.datetime :due_date
      t.integer :quizlet_id
      t.references :admin, index: true
      t.references :classroom, index: true

      t.timestamps
    end
  end
end
