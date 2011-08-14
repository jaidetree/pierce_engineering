class Admin::ProductsController < ApplicationController

	include ProductsLib
	include PhotoSystem

	before_filter :get_product_type

	# GET /products
	# GET /products.xml
	def index

		@products = Product.joins( :product_category ).where( 'product_categories.cat_type' => @product_type ).all

		respond_to do |format|
			format.html { render ProductsLib.template params[:action] }
			format.xml  { render :xml => @products }
		end
	end

	# GET /products/1
	# GET /products/1.xml
	def show
		@product = Product.find(params[:id])

		respond_to do |format|
			format.html { render ProductsLib.template params[:action] }
			format.xml  { render :xml => @product }
		end
	end

	# GET /products/new
	# GET /products/new.xml
	def new
		@product = Product.new

		respond_to do |format|

			format.html { render ProductsLib.template }
			format.xml  { render :xml => [:admin, @product] }
		end
	end

	# GET /products/1/edit
	def edit
		@product = Product.find(params[:id])

		respond_to do |format|
			format.html { render ProductsLib.template }
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

		respond_to do |format|
			if @product.save

				if( image )
					image.product = @product
					image.save
				end
				
				if params && params[:type] == "rifle" 
					template = edit_admin_rifle_path( @product )
					notice = "Rifle"
				else
					template = edit_admin_product_path( @product )
					notice = "Product"
				end

				format.html { redirect_to( template, :notice => notice + ' was successfully saved.') }
				format.xml  { render :xml => @product, :status => :created, :location => @product }
			else
				format.html { render ProductsLib.template "new" }
				format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /products/1
	# PUT /products/1.xml
	def update
		@product = Product.find(params[:id])

        if params && params[:type] == "rifle"
			template = admin_rifle_path( @admin_product )
			notice = 'Rifle'
		else
			template = admin_product_path( @admin_product )
			notice = 'Product'
		end              

		respond_to do |format|
			if @product.update_attributes(params[:product])
				format.html { redirect_to( template, :notice => notice + ' was successfully updated.') }
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
		@product.destroy

        if rifle_page?
			url = admin_rifle_categories_path
			notice = "Rifle"
		else
			url = admin_rifle_categories_path
			notice = "Product"
		end           

		respond_to do |format|
			format.html { redirect_to( url, :notice => notice + " was successfully deleted." ) }
			format.xml  { head :ok }
		end
	end

	def get_product_type
		@product_type = ProductsLib.setup(request.fullpath)
	end

end
