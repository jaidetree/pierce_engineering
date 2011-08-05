class ApplicationController < ActionController::Base
	protect_from_forgery
	layout :page_layout
	before_filter :authenticate

	protected
		# Returns the currently logged in user or nil if there isn't one
		def current_user
			return false unless session[:user_id]
			@current_user ||= User.find_by_id( session[:user_id] )
		end

		# Make current user available in templates as a helper
		helper_method :current_user

		# Filter method to enforce a login requirement
		# Apply as a before_filter on any controller you want to protect
		def authenticate
			if is_admin? then
				logged_in? ? true : access_denied
			end
		end

		# Predicate method to test for a logged in user
		def logged_in?
			current_user.is_a? User
		end

		# Make logged_in? available in templates as a helper
		helper_method :logged_in?

		def access_denied
			redirect_to admin_login_path, :notice => "Please log in to continue" and return false
		end

		def is_admin?
			/^\/admin/.match( request.fullpath ) ? true : false
		end

		# Check to see what page we're in.
		helper_method :current_controller?

		def current_controller?( controller, action=false )
			page = ActionController::Routing::Routes.recognize_path request.fullpath
            
			controller_found = controller == page[:controller]
			
			( action ) ? action == page[:action] && controller_found : controller_found
		end

	private 
		def page_layout
			is_admin? ? 'admin' : 'application'
		end
	

end
