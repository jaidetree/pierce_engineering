module Admin::DashboardHelper
	def nav_link( title, url, module_name='', action=false, options={} )

		if ! options[:class] || options[:class].blank?
			options[:class] = ''
		end
		if module_name.blank?
			module_name = title.clean
		end

		if ! action
			options[:class] = module_name
		end

		if current_controller? 'admin/' + module_name.gsub( '-', '_' ), action
			options[:class] += ' selected'
		end

		link_to title, url, options
	end
end
