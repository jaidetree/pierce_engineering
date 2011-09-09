module SettingsHelper
	def get_setting( group_key, setting_name )
		setting = @settings[group_key]
		return setting[ setting_name ] ? setting[ setting_name ] : ''
	end
end
