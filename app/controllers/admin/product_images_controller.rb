class Admin::ProductImagesController < ApplicationController

	before_filter :load_product, :except => 'index'

	include PhotoSystem

	# GET /product_images
	# GET /product_images.xml
	def index
		@products = Product.all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @products }
		end
	end

	# GET /product_images/1
	# GET /product_images/1.xml
	def show
		@product_image = ProductImage.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @product_image }
		end
	end

	# GET /product_images/new
	# GET /product_images/new.xml
	def new
		@product_image = @product.product_images.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @product_image }
		end
	end

	# GET /product_images/1/edit
	def edit
		@product_image = @product.product_images.new
	end

	# POST /product_images
	# POST /product_images.xml
	def create
		@product_image = @product.product_images.new( params[:product_image] )

		if params[:product_image][:file] 
			@product_image.images = PhotoSystem.upload( params[:product_image][:file] ) 
		else
			@product_image.images = {}
		end


		respond_to do |format|
			if @product_image.save
				format.html { redirect_to( new_admin_product_product_image_path( @product ), :notice => 'Product image was successfully created.') }
				format.xml  { render :xml => @product_image, :status => :created, :location => @product_image }
				format.js
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @product_image.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /product_images/1
	# PUT /product_images/1.xml
	def update
		@product_image = ProductImage.find(params[:id])

		respond_to do |format|
			if @product_image.update_attributes(params[:product_image])
				format.html { redirect_to(@product_image, :notice => 'Product image was successfully updated.') }
				format.xml  { head :ok }
				format.js   { render :nothing => true }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @product_image.errors, :status => :unprocessable_entity }
				format.js
			end
		end
	end

	# DELETE /product_images/1
	# DELETE /product_images/1.xml
	def destroy
		@product_image = @product.product_images.find(params[:id])
		PhotoSystem.delete_photos @product_image.images
		@product_image.destroy

		respond_to do |format|
			format.html { redirect_to(product_images_url) }
			format.xml  { head :ok }
			format.js 
		end
	end

	# POST /products/1/product_images/1/select
	def select

		@product_image = @product.product_images.find( params[:id] )

		begin
			selected_images = @product.product_images.where( :image_selected => true ).first

			if selected_images 
				selected_images.update_attributes( :image_selected => false )
			end

		rescue ActiveRecord::RecordNotFound
			# error handling
		end

		respond_to do |format|
			if @product_image.update_attributes( :image_selected => ! @product_image.selected? )
				format.js
			else
				# error handling
			end
		end
	end

	private
	def load_product
		@product = Product.find_by_slug(params[:product_id]) || Product.find(params[:product_id])
	end
end
