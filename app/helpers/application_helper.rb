module ApplicationHelper
	def is_selected?( page )
		return "selected" if path_matches?( /^(\/)?#{page}$/ ) 
	end
end
