class ProductCategory < ActiveRecord::Base
	validates :name, :presence => true, :uniqueness => true

	has_many :products
	belongs_to :user

	before_save :make_slug

	def to_param
		self.slug
	end

	def slug
		slug = read_attribute( :slug )
		return if self.name.blank?
		@slug ||= (slug) ? slug : self.name.clean
	end

	protected 
		def make_slug
			if slug.blank?
				self.slug = self.name.clean
			else
				self.slug = slug.clean
			end
		end
end
