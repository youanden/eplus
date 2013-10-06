class Classroom < ActiveRecord::Base
  belongs_to :admin
  has_many :assignments
  has_and_belongs_to_many :students
  validates_presence_of :admin
  validates_presence_of :name
  validates_uniqueness_of :quizlet_id, allow_blank: true, allow_nil: true

  def self.find_or_create(attributes)
    Classroom.where(attributes).first || Classroom.create(attributes)
  end
end
