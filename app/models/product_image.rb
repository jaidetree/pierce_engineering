class ProductImage < ActiveRecord::Base
  belongs_to :product
  serialize :images

  attr_accessor :file
  attr_accessor :caption

  def caption
	  return '' if ! images
      @caption ||= image_caption.blank? ? '<em>No Caption</em>'.html_safe : image_caption 
  end

  def find_selected( product_id )
		return ProductImage.find_by_product_id_and_image_selected( product_id, true).first
  end

  def selected?
	  ( self.image_selected == true ) ? true : false
  end

  def unselect
	  self.image_selected = false
  end

  def select
	  self.image_selected = true
  end

  def has_caption?
	  self.caption && self.caption != "<em>No Caption</em>" ? true : false
  end

end
