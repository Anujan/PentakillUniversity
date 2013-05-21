class App < ActiveRecord::Base
  belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id', polymorphic: true
  belongs_to :mentor, :class_name => 'Mentor', :foreign_key => 'mentor_id', polymorphic: true
  validates :mentor_id, :uniqueness => { :scope => :student_id }
  attr_accessible :id, :mentor_id, :message, :student_id
enda