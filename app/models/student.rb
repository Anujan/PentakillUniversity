class Student < User
  has_many :apps, :foreign_key => 'student_id', :class_name => 'App', :finder_sql => Proc.new {
    %Q{
      SELECT "apps".* FROM "apps" 
      WHERE "apps"."student_id" = #{id}
    }
  }
  has_many :requests, :foreign_key => 'student_id', :class_name => 'Request', :finder_sql => Proc.new {
    %Q{
      SELECT "requests".* FROM "requests" 
      WHERE "requests"."student_id" = #{id}
    }
  }
  has_one :relationship, :foreign_key => 'student_id', :class_name => 'Relationship'
end