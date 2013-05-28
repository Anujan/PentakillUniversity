class AppController < ApplicationController
  before_filter :authenticate_user!
  def accept
  	app = App.find(params[:id])
  	flash[:app_id] = app.id
  	redirect_to :controller => 'user', :action => 'request_mentorship', :id => app.student.id
  end

  def decline
  	@app = App.find(params[:id])
  	unless (@app.nil? || @app.mentor_id != current_user.id)
  		@app.destroy
  	end
  	redirect_to :back
  end

  def create
  	mentor = Mentor.find(params[:app][:mentor])
  	if (mentor.nil?)
  		redirect_to root_path
  		return
  	end
  	App.create(:student_id => current_user.id, :mentor_id => mentor.id, :message => params[:app][:message])
  	flash[:notice] = "Your application to #{mentor.ign} was submitted. Please wait for his reply."
  	redirect_to root_path
  end
end