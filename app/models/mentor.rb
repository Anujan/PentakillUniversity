class Mentor < User
  has_many :applications, :foreign_key => 'mentor_id', :class_name => 'Application', :finder_sql => Proc.new {
    %Q{
      SELECT "applications".* FROM "applications" 
      WHERE "applications"."mentor_id" = #{id}
    }
  }
  has_many :requests, :foreign_key => 'mentor_id', :class_name => 'Request', :finder_sql => Proc.new {
    %Q{
      SELECT "requests".* FROM "requests" 
      WHERE "requests"."mentor_id" = #{id}
    }
  }
  has_many :relationships, :foreign_key => 'mentor_id', :class_name => 'Relationship', :finder_sql => Proc.new {
    %Q{
      SELECT "relationships".* FROM "relationships" 
      WHERE "relationships"."mentor_id" = #{id}
    }
  }

end