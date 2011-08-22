class Admin::ProductsController < ApplicationController

	include ProductsLib
	include PhotoSystem

	before_filter :get_product_type

	# GET /products
	# GET /products.xml
	def index

		@products = Product.joins( :product_category ).where( 'product_categories.cat_type' => @product_type ).all

		respond_to do |format|
			format.html
			format.xml  { render :xml => @products }
		end
	end

	# GET /products/1
	# GET /products/1.xml
	def show
		@product = Product.find_by_slug(params[:id]) || Product.find(params[:id])

		respond_to do |format|
			format.html
			format.xml  { render :xml => @product }
		end
	end

	# GET /products/new
	# GET /products/new.xml
	def new
		@product = Product.new

		respond_to do |format|

			format.html
			format.xml  { render :xml => [:admin, @product] }
		end
	end

	# GET /products/1/edit
	def edit
		@product = Product.find_by_slug(params[:id]) || Product.find(params[:id])
		@product_label = ( @product.product_category.cat_type == 1 ) ? "rifle" : "product"
		@product_type = @product_label == "rifle" ? 1 : 0

		respond_to do |format|
			format.html
			format.xml  { render :xml => @admin_product_category }
		end
	end

	# POST /products
	# POST /products.xml
	def create
		@user = current_user
		@product = @user.products.new(params[:product])

		if !params[:image].nil?
			image = ProductImage.new( :image_caption => params[:image][:caption], :image_selected => true )
			image.images = PhotoSystem.upload params[:image][:file]
		end

		if params[:type] && params[:type] == "product"
			template = admin_products_path
			notice = "Product"
			@product_type = 0
			@product_label = "product"
		else
			template = admin_rifles_path
			notice = "Rifle"
			@product_type = 1
			@product_label = "rifle"
		end

		respond_to do |format|
			if @product.save

				if( image )
					image.product = @product
					image.save
				end


				format.html { redirect_to( template, :notice => notice + ' was successfully saved.') }
				format.xml  { render :xml => @product, :status => :created, :location => @product }
			else
				format.html { render :action => 'new' }
				format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /products/1
	# PUT /products/1.xml
	def update
		@product = Product.find_by_slug(params[:id]) || Product.find(params[:id])
		@product_label = ( @product.product_category.cat_type == 1 ) ? "rifle" : "product"
		@product_type = @product_label == "rifle" ? 1 : 0

		if( @product_label == "rifle" )
			url = admin_rifles_path
			notice = "Rifle"
		else
			url = admin_products_path
			notice = "Product"
		end

		respond_to do |format|
			if @product.update_attributes(params[:product])
				format.html { redirect_to( url, :notice => notice + ' was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /products/1
	# DELETE /products/1.xml
	def destroy
			@product = Product.find(params[:id])

		if @product.product_category.cat_type == 0
			url = admin_rifle_categories_path
			notice = "Rifle"
			else
			url = admin_rifle_categories_path
			notice = "Product"
		end           

		@product.destroy

		respond_to do |format|
			format.html { redirect_to( url, :notice => notice + " was successfully deleted." ) }
			format.xml  { head :ok }
		end
	end

	def get_product_type
		@product_type, @product_label = ProductsLib.setup(request.fullpath)
	end

end
