class Admin::SessionsController < ApplicationController
	layout 'session'
	skip_before_filter :authenticate

	def create
		if ! params[:email] 
			render :action => 'new'
			return
		end
		if user = User.authenticate( params[:email], params[:password] )
			session[:user_id] = user.id
			redirect_to admin_root_path, :notice => "Logged in successfully"
		else
			flash.now[:alert] = "Invalid login/password combination"
			render :action => 'new'
		end
	end

	def destroy
		reset_session
		flash.now[:notice] = "You have logged out."
		render :action => 'new'
	end
end
