class ProductImage < ActiveRecord::Base
  belongs_to :product
  serialize :images

  attr_accessor :file
  attr_accessor :caption

  def caption
	  return '' if ! images
      @caption ||= image_caption.blank? ? '<em>No Caption</em>'.html_safe : image_caption 
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

end
