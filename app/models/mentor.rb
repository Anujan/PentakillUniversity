class Mentor < User
  has_many :apps, :foreign_key => 'mentor_id', :class_name => 'App', :finder_sql => Proc.new {
    %Q{
      SELECT "apps".* FROM "apps" 
      WHERE "apps"."mentor_id" = #{id}
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