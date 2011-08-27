class Page < ActiveRecord::Base
    require 'rss'
	include DataTable

	serialize :data
	before_save :process_data

	def slug
		slug = read_attribute( :slug )
		return if self.name.blank?
		slug ? slug : self.name.clean
	end

	def to_param
		self.slug
	end

	def data_hash
		return DataTable.get_hash( data )
	end

	def rss_items( key )
		return {} if ! self.data_hash
		rss = RSS::Parser.parse( open(self.data_hash[key]).read, false)
		rss.items
	end

	protected 

	def process_data
		if slug.blank?
			self.slug = self.name.clean
		else
			self.slug = slug.clean
		end

		self.data = DataTable.assemble_hash_from_array( self.data )
	end

end
