module DataTable
	def self.assemble_hash_from_array( data )
		return {} if data.nil?
		data_keys = data[:keys]
		data_values = data[:values]

		hash = {}

		if data_keys.class.name == "Array" 
			data_keys.each_with_index do |key, index|
				hash[ key ] = data_values[ index ]
			end
		end

		return hash

	end

	def self.get_hash( data )
		return {} if data.class.name == "String" || data.nil? 
		return assemble_hash_from_array( data ) if not data[:keys].nil?
		data.class.name.match( /^Hash/) || ( data[:keys] && data[:values] ) ? data : {} 
	end
end
