class Request < ActiveRecord::Base
  belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id', polymorphic: true
  belongs_to :mentor, :class_name => 'Mentor', :foreign_key => 'mentor_id', polymorphic: true
  attr_accessible :id, :mentor_id, :student_id, :price, :goal_tier, :goal_division
  validates :goal_tier, :goal_division, :presence => true
  validates :mentor_id, :uniqueness => { :scope => :student_id }

  def paypal_url(return_url, notify_url) 
	values = { 
		:business => "Anujan714-facilitator@gmail.com",
		:cmd => '_cart',
		:upload => 1,
		:return => return_url,
		:notify => notify_url,
		:invoice => (3000 + self.id)
	}
	values.merge!({ 
		"amount_1" => price,
		"item_name_1" => "Mentoring from #{mentor.ign}",
		"item_number_1" => id,
		"quantity_1" => '1'
	})
	values.merge!({
		"amount_2" => price * 0.05,
		"item_name_2" => "5% Escrow Fee",
		"item_number_2" => 5000 + id,
		"quantity_2" => '1'
	})
	return "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
