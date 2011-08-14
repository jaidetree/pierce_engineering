class Admin::ProductsController < ApplicationController

	include ProductsLib

	before_filter :get_product_type

	# GET /products
	# GET /products.xml
	def index

		@products = Product.joins( :product_category ).where( 'product_categories.cat_type' => @product_type ).all

		respond_to do |format|

			if rifle_page?
				format.html { render ProductsLib.type_action 'index' }
			else
				format.html # index.html.erb
			end

			format.xml  { render :xml => @products }
		end
	end

	# GET /products/1
	# GET /products/1.xml
	def show
		@product = Product.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @product }
		end
	end

	# GET /products/new
	# GET /products/new.xml
	def new
		@product = Product.new

		respond_to do |format|

			if rifle_page?
				format.html { render ProductsLib.type_action 'new' }
			else
				format.html # new.html.erb
			end

			format.xml  { render :xml => [:admin, @product] }
		end
	end

	# GET /products/1/edit
	def edit
		@product = Product.find(params[:id])
	end

	# POST /products
	# POST /products.xml
	def create
		@user = current_user
		@product = @user.products.new(params[:product])

		respond_to do |format|
			if @product.save
				if rifle_page?
					format.html { redirect_to( edit_admin_rifle_path( @product ), :notice => 'Rifle was successfully created.') }
					format.xml  { render :xml => @product, :status => :created, :location => @product }
				else
					format.html { redirect_to( edit_admin_product_path( @product ), :notice => 'Product was successfully created.') }
					format.xml  { render :xml => @product, :status => :created, :location => @product }
				end
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /products/1
	# PUT /products/1.xml
	def update
		@product = Product.find(params[:id])

		respond_to do |format|
			if @product.update_attributes(params[:product])
				if rifle_page?
					format.html { redirect_to( edit_admin_rifle_path( @product ), :notice => 'Rifle was successfully updated.') }
					format.xml  { head :ok }
				else
					format.html { redirect_to( [:admin, @product], :notice => 'Product was successfully updated.') }
					format.xml  { head :ok }
				end
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => [:admin, @product.errors], :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /products/1
	# DELETE /products/1.xml
	def destroy
		@product = Product.find(params[:id])
		@product.destroy

		respond_to do |format|
			if rifle_path? 
				format.html { redirect_to( admin_rifles_path ) }
				format.xml  { head :ok }
			else
				format.html { redirect_to( admin_products_path ) }
				format.xml  { head :ok }
			end
		end
	end

	def get_product_type
		@product_type = ProductsLib.setup(admin_rifles_path, request.fullpath)
	end

end
