class Student < ActiveRecord::Base
  has_and_belongs_to_many :classrooms, uniq: true
  has_many :grades
  validates :username, presence: true, uniqueness: true

  def get_grade_for(assignment)
    grade = self.grades.where(assignment_id: assignment.id).first
    return grade ? grade.value : "N/A"
  end
end
