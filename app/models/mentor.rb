class Mentor < User
  has_many :apps, :foreign_key => 'mentor_id', :class_name => 'App'
  has_many :requests, :foreign_key => 'mentor_id', :class_name => 'Request'
  has_many :relationships, :foreign_key => 'mentor_id', :class_name => 'Relationship'

end