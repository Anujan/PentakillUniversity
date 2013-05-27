class Student < User
  has_many :apps, :foreign_key => 'student_id', :class_name => 'App'
  has_many :requests, :foreign_key => 'student_id', :class_name => 'Request'
  has_one :relationship, :foreign_key => 'student_id', :class_name => 'Relationship'
end