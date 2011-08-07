class ProductCategory < ActiveRecord::Base
	attr_accessor :slug

	validates :name, :presence => true, :uniqueness => true

	has_many :products
	belongs_to :user

	before_save :make_slug

	def slug
		return if self.name.blank?
		@slug ||= (self.safe_name) ? self.safe_name : self.name.clean
	end


	protected 
		def make_slug
			if slug.blank?
				self.safe_name = self.name.clean
			else
				self.safe_name = slug.clean
			end
		end
end
