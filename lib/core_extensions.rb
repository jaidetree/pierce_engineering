class String
	def clean
		name = self.to_s
		name = name.strip
		name = name.gsub ' ','-' 
		phrases = name.downcase.scan /[-a-z0-9]+/i
		return phrases.join( '' )
	end
end
