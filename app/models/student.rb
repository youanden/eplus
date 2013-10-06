class Student < ActiveRecord::Base
  has_and_belongs_to_many :classrooms, uniq: true
  validates :username, presence: true, uniqueness: true
end
