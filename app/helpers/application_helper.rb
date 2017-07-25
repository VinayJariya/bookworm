module ApplicationHelper

	# Returns full title for Pages
	def full_title(title = "")
		@base_title = "BookWorm: A Portal for BookWorms"
		title.empty? ? @base_title : "#{title} | #{@base_title}"
	end

	# Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    
    # Confirms an Admin User
	def admin_user
	  unless current_user.admin?
        flash[:danger] = "Log in as Admin."
        redirect_to(root_url)
	    end  
	  end

	def correct_user_for_book
		@user = User.find_by(id: (Book.find_by(id: params[:id]).user_id))
	    unless current_user?(@user)
	        flash[:danger] = "Log in as correct user."
	        redirect_to(root_url)
	    end   
	end

	# Confirms the correct user.
    def correct_user_for_profile
       @user = User.find(params[:id])
       unless current_user?(@user)
        flash[:danger] = "Log in as correct user."
        redirect_to(root_url)
      end      
    end


end
