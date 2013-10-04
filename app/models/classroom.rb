class Classroom < ActiveRecord::Base
  belongs_to :admin
  has_many :assignments
end
