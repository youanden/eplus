class Student < ActiveRecord::Base
  has_and_belongs_to_many :classrooms, uniq: true
  has_many :grades
  validates :username, presence: true, uniqueness: true

  def get_grade_for(assignment)
    grade = self.grades.where(assignment_id: assignment.id).first
    return grade ? grade.value : "N/A"
  end

  def get_grade_for_mode(assignment, mode)
    grade = self.grades.where(assignment_id: assignment.id, mode: mode).first
    if mode == 'scatter' or mode == 'spacerace'
      # raise "T" if self.username == "youanden"
      return defined?(grade.score) ? grade.score : "N/A"
    else
      return grade ? grade.value : "N/A"
    end
  end
end
