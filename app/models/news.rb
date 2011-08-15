class News < ActiveRecord::Base
	serialize :products
	belongs_to :user

	def products
		products = read_attribute( :products )
		products ? products : []
	end
end
