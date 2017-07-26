class UsersController < ApplicationController
  
  include ApplicationHelper 

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user_for_profile, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :index]
  
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to otp_verification_path(id: @user.id)
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
    unless @user.activated?
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url and return
    end
    unless @user.contact_verified?
      flash[:info] = "Please verify your contact to activate your account."
      redirect_to otp_verification_path(id: @user.id) and return
    end
  end

   def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
     @users = User.where(activated: true).paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def otp_verification
    @user = User.find_by_id(params[:id])
    if !@user.contact_verified?
      @contact = "XXXXXX#{@user.contact[6..9]}"
      @user.send_otp
    else
      flash[:danger] = "Invalid link !!!"
      redirect_to root_url
    end
  end

  def otp_verified
    @user = User.find_by_id(params[:id])
    otp = params[:otp]
    puts otp
    if @user.authenticate_otp("#{otp}", drift: 300)
      @user.update_attribute(:contact_verified, true)
      flash[:success] = "Contact Verified"
      log_in @user
      redirect_to @user
    else
      redirect_to 'otp_verification'
    end
  end

  private

   def user_params
   	params.require(:user).permit(:name, :email, :contact, :password, :password_confirmation)
   end

  
end
