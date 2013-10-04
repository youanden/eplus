class Classroom < ActiveRecord::Base
  belongs_to :admin
  has_many :assignments
  validates_presence_of :admin
  validates_presence_of :name
end
