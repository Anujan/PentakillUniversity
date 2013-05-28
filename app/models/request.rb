class Request < ActiveRecord::Base
  belongs_to :student
  belongs_to :mentor
  attr_accessible :id, :mentor_id, :student_id, :price, :goal_tier, :goal_division
  validates :goal_tier, :goal_division, :presence => true
  validates :mentor_id, :uniqueness => { :scope => :student_id }

  def paypal_url(return_url, notify_url) 
	values = { 
		:business => "Anujan714-facilitator@gmail.com",
		:cmd => '_cart',
		:upload => 1,
		:return => return_url,
		:notify => notify_url.gsub!("localhost", "99.228.77.37"),
		:invoice => (3000 + self.id)
	}
	values.merge!({ 
		"amount_1" => price.to_s,
		"item_name_1" => "Mentoring from #{mentor.ign}",
		"item_number_1" => id,
		"quantity_1" => '1'
	})
	values.merge!({
		"amount_2" => (price * 0.05 + 0.3).to_s,
		"item_name_2" => "5% Escrow Fee + Paypal Fee",
		"item_description_2" => "Fee for us holding your money and acting as a middleman. This prevents both parties from being scammed.",
		"item_number_2" => 5000 + id,
		"quantity_2" => '1'
	})
	return "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
