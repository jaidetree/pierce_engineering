class Admin::RiflesController < ApplicationController
	# GET /products
	# GET /products.xml
	def index

		product_category = ProductCategory.find_by_cat_type(1)
		
		if( product_category.nil? )
			@products = []
		else
			@products = product_category.products.all
		end

		respond_to do |format|
			format.html # index.html.erb
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
			format.html # new.html.erb
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
				format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
				format.xml  { render :xml => @product, :status => :created, :location => @product }
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
				format.html { redirect_to( [:admin, @product], :notice => 'Product was successfully updated.') }
				format.xml  { head :ok }
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
			format.html { redirect_to(products_url) }
			format.xml  { head :ok }
		end
	end
end