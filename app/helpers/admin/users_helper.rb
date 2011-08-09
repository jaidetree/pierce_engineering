module Admin::UsersHelper
	def link_user(user, options={})
		link_to user, admin_user_path( user ), options
	end
end
