class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.integer :quizlet_id
      t.references :admin, index: true

      t.timestamps
    end
  end
end
