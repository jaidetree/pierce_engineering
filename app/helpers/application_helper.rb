module ApplicationHelper
	def is_selected?( page )
		return "selected" if page === true
		return "selected" if path_matches?( /^(\/)?#{page}$/ ) 
	end
end
