class CreateClassroomsStudents < ActiveRecord::Migration
  def change
    create_table :classrooms_students do |t|
      t.belongs_to :classroom
      t.belongs_to :student
    end
  end
end
