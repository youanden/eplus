class Classroom < ActiveRecord::Base
  belongs_to :admin
  has_many :assignments
  has_and_belongs_to_many :students, uniq: true
  validates_presence_of :admin
  validates_presence_of :name
  validates_uniqueness_of :quizlet_id, allow_blank: true, allow_nil: true
end
