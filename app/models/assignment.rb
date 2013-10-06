class Assignment < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :admin
  has_many :grades
end
