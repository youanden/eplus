class Student < ActiveRecord::Base
  has_and_belongs_to_many :classrooms
  validates :username, presence: true, uniqueness: true

  def self.find_or_create(attributes)
    Student.where(attributes).first || Student.create(attributes)
  end
end
