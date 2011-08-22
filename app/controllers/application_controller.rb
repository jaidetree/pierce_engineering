class ApplicationController < ActionController::Base
	protect_from_forgery
	layout :page_layout
	before_filter :authenticate
	before_filter :navigation_resources

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
			page = Rails.application.routes.recognize_path request.fullpath
            
			controller_found = controller == page[:controller]
			
			( action ) ? action == page[:action] && controller_found : controller_found
		end

		helper_method :current_path?

		def current_path?( path )
			return path == request.fullpath ? true : false
		end

		helper_method :path_matches?

		def path_matches?( path )
			if path.class.name == "Regexp" 
				return true if request.fullpath.match path
			else
				return true if request.fullpath.match /#{path}/ 
			end
		end

		def rifle_page?
			path_matches?('admin/rifle') ? true : false
		end

		def navigation_resources
			return if is_admin?
			@all_products = ProductCategory.find_all_by_cat_type( 0 )
			@all_rifle_cats = ProductCategory.find_all_by_cat_type( 1 )
		end


	private 
		def page_layout
			is_admin? ? 'admin' : 'application'
		end
	

end
