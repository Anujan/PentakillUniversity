class RequestController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :only => [:notify]
  def accept
  	req = Request.find(params[:id])
    if (!current_user.is_mentor? && !current_user.relationship.nil?)
      flash[:error] = "You can only have 1 mentor at a time. Sorry."
    elsif (current_user.is_mentor? && current_user.relationships.size > 2)
      flash[:error] = "You can only have 3 students at a time, sorry!"
    else
    	if (req.student.id == current_user.id)
    		if (req.price > 0)
    		  return
        else
          req.student.relationship = Relationship.create(:mentor => req.mentor, :price => req.price)
    			flash[:notice] = "You're now being mentored by #{req.mentor.ign}!"
          current_user.requests.each do |request| 
            if (request.student.id == current_.id)
              request.destroy
            end
          end
    		end
    	end
    end
    redirect_to user_requests_path
  end

  def decline
  	req = Request.find(params[:id])
  	if (req.student.id == current_user.id)
  		req.destroy
  	end
  	redirect_to user_requests_path
  end

  def notify
    Rails.logger.info(params.inspect)
    PaymentNotification.create!(:params => params, :request_id => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id] )
    render :nothing => true
  end

  def create
    student = Student.find(params[:request][:student])
    if (student.nil?)
      return redirect_to root_path
    end
    req = student.requests.create(:price => params[:request][:price], :mentor_id => current_user.id, :goal_tier => params[:request][:goal_tier], :goal_division => params[:request][:goal_division])
    current_user.apps.each do |app| 
      if (app.student.id == student.id)
        app.destroy
      end
    end
    flash[:notice] = "Your request has been sent to #{student.ign}. Please wait for a response."
    redirect_to root_path
  end
end