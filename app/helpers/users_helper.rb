module UsersHelper
	def link_user(user,options={})
		link_to user.first_name, [:admin, user], options
	end
end
