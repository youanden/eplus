class Grade < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :student
  validates_presence_of :assignment
  validates_presence_of :student
end
