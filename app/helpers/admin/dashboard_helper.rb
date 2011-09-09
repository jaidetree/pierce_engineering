module Admin::DashboardHelper
	def nav_link( title, url, module_name='', action=false, options={}, strict=false )

		if ! options[:class] || options[:class].blank?
			options[:class] = ''
		end
		if module_name.blank?
			module_name = title.clean
		end               
		
		if ! action && options[:class].empty?
			options[:class] = module_name
		end

		if( strict )
			pattern = strict.class.name == "Regexp" ? strict : "^/#{module_name}/?$"
			if request.fullpath.to_s.match pattern 
				options[:class] += ' selected'
			end
		else
			if current_controller? 'admin/' + module_name.gsub( '-', '_' ), action
				options[:class] += ' selected'
			end
		end                         

		link_to title.capitalize, url, options
	end

	def display_hash( hash )
        html = ""
		hash.each_pair do |key, value|
			html << content_tag( :ul ) do
				content_tag( :li ) do
					key + ": $" + value
				end
			end
		end

		html
	end
end
