require "net/http"
require "uri"

class PaymentNotification < ActiveRecord::Base
  attr_accessible :create, :params, :request_id, :status, :transaction_id
  serialize :params
  after_create :create_relationship

  private

  def create_relationship
  	if status == 'Completed'
  		req = Request.find(request_id)
  		unless req.nil?
        return Rails.logger.info("PaymentNotification #{id} has the wrong price...\r\nmc_gross_1 = #{params[:mc_gross_1]}\r\nprice = #{req.price}") if (params[:mc_gross_1].to_f != req.price.to_f || params[:mc_currency] != 'USD')
  			req.student.relationship =  Relationship.create(:mentor => req.mentor, :price => req.price, :payment_id = self.id)
  			self.request_id = req.student.relationship.id
  			self.save!
  			req.destroy
  		end
  	end
  end
end