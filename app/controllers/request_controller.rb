class RequestController < ApplicationController
  before_filter :authenticate_user!
  def accept
  	req = Request.find(params[:id])
    if (!current_user.is_mentor? && current_user.relationships.size > 0)
      flash[:error] = "You can only have 1 mentor at a time. Sorry."
    elsif (current_user.is_mentor? && current_user.relationships.size > 2)
      flash[:error] = "You can only have 3 students at a time, sorry!"
    else
    	if (req.student.id == current_user.id)
    		if (req.price > 0)
          redirect_to req.paypal_url(url_for(:controller => "user", :action => "requests", :only_path => false), url_for(:action => 'notify', :only_path => false))
    		  return
        else
          req.student.relationships.create(:mentor => req.mentor, :price => req.price)
    			flash[:notice] = "You're now being mentored by #{req.mentor.ign}!"
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
  	if params[:item_number1] && !params[:item_number1].empty?
  		if params[:payment_status] != 'Voided'
  			@request = Request.find(params[:item_number1].to_i)
        return if request.blank?
  			if (@request.mc_gross == (@request.price * 1.05) || @request.mc_gross_1 == @request.price)
  				rel = @request.student.relationships.create(:mentor => req.mentor, :price => @request.price, :payment_id => @request.txn_id)
          if (rel.save!)
            @request.destroy
          end
  			end
  		end
  	end
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