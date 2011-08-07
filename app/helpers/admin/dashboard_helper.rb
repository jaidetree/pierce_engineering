module Admin::DashboardHelper
	def module_link( title, url, module_name, class_att, options={} )
		options[:class] = class_att

		if current_controller? 'admin/' + module_name 
			options[:class] += ' selected'
		end

		link_to title, url, options
	end
end
