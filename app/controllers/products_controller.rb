class ProductsController < ApplicationController
	# GET /products
	# GET /products.xml
	def index
		@categories = path_matches?(/products/) ? ProductCategory.find_all_by_cat_type( 0 ) : ProductCategory.find_all_by_cat_type( 1 )
		@product_type = path_matches?(/products/) ? 'product' : 'rifle'
		@title = @product_type.capitalize + 's'

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @products }
		end
	end

	# GET /products/1
	# GET /products/1.xml
	def show
		@product = Product.find_by_slug(params[:id]) || Product.find(params[:id])
        @product_type = @product.product_category.cat_type == 1  ? "rifle" : "product"
		@title = @product.name

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @product }
		end
	end
end
