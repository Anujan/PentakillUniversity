class Request < ActiveRecord::Base
  belongs_to :student
  belongs_to :mentor
  attr_accessible :id, :mentor_id, :student_id, :price, :goal_tier, :goal_division
  validates :goal_tier, :goal_division, :presence => true
  validates :mentor_id, :uniqueness => { :scope => :student_id }

  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end

  def paypal_url(return_url, notify_url) 
		values = { 
			:business => "Anujan714@gmail.com",
			:cmd => '_cart',
			:upload => 1,
			:return => return_url,
			:notify => notify_url
		}
		values.merge!({ 
			"amount_1" => price.round(2).to_s,
			"item_name_1" => "Mentoring from #{mentor.ign}",
			"item_number_1" => id,
			"quantity_1" => '1'
		})
		values.merge!({
			"amount_2" => ((price * 0.05 + 0.3) + (price * 0.05)).round(2),
			"item_name_2" => "Escrow Fee + Paypal Fee. This fee is non-refundable.",
			"item_description_2" => "Fee for us holding your money and acting as a middleman. This prevents both parties from being scammed. If you wish to not pay this, you may re-request the student with a price of 0 and make payments by yourself, but we are not responsible for any scamming.",
			"item_number_2" => 5000 + id,
			"quantity_2" => '1'
		})
		real_values = {
			:cmd => "_s-xclick",
			:encrypted => encrypt_for_paypal(values)
		}
		return "https://www.paypal.com/cgi-bin/webscr?" + real_values.to_query()
  end
end
