class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]
  def create
  	return false unless request_valid?
    PaymentNotification.create!(:params => params, :request_id => params[:item_number1], :status => params[:payment_status], :transaction_id => params[:txn_id] )
    render :nothing => true
  end
  def request_valid?
    uri = URI.parse('https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate')

    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, request.raw_post,
                         'Content-Length' => "#{request.raw_post.size}",
                         'User-Agent' => "Anujan"
                       ).body

    raise StandardError.new("Faulty paypal result: #{response}") unless ["VERIFIED", "INVALID"].include?(response)
    raise StandardError.new("Invalid IPN: #{response}") unless response == "VERIFIED"

    true
  end
end