class App < ActiveRecord::Base
  belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
  belongs_to :mentor, :class_name => 'Mentor', :foreign_key => 'mentor_id'
  validates :mentor_id, :uniqueness => { :scope => :student_id }
  attr_accessible :id, :mentor_id, :message, :student_id
end