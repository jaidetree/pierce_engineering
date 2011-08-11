class ProductImage < ActiveRecord::Base
  belongs_to :product
  serialize :images

  attr_accessor :file
end
