class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		flash[:success] = "Welcome #{user.name}"
  		log_in(user)
  		redirect_to user_url(user)
  	else
  		flash.now[:danger] = "Invalid Credentials"
  		render 'new'
  	end
  end

  def destroy
  	logout
  	flash[:success] = "You have been successfully logged out !!!"
  	redirect_to root_path
  end

end
