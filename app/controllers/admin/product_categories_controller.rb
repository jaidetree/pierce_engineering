class Admin::ProductCategoriesController < ApplicationController
	include ProductsLib

	before_filter :setup

	# GET /admin/product_categories
	# GET /admin/product_categories.xml
	def index

		@admin_product_categories = ProductCategory.find_all_by_cat_type( @product_type )

		respond_to do |format|
			format.html { render ProductsLib.template params[:action] }
			format.xml  { render :xml => @admin_product_categories }
		end
	end

	# GET /admin/product_categories/1
	# GET /admin/product_categories/1.xml
	def show
		@admin_product_category = ProductCategory.find(params[:id])

		respond_to do |format|
			format.html { render ProductsLib.template params[:action] }
			format.xml  { render :xml => @admin_product_category }
		end
	end

	# GET /admin/product_categories/new
	# GET /admin/product_categories/new.xml
	def new
		@admin_product_category = ProductCategory.new

		respond_to do |format|
			format.html { render ProductsLib.template }
			format.xml  { render :xml => @admin_product_category }
		end
	end

	# GET /admin/product_categories/1/edit
	def edit
		@admin_product_category = ProductCategory.find(params[:id])

		respond_to do |format|
			format.html { render ProductsLib.template }
			format.xml  { render :xml => @admin_product_category }
		end
	end

	# POST /admin/product_categories
	# POST /admin/product_categories.xml
	def create
		@user = current_user
		@admin_product_category = @user.product_categories.new(params[:product_category])

		if params && params[:type] == "rifle" 
			template = admin_rifle_categories_path
			notice = "Rifle Category was successfully created."
		else
			template = admin_product_categories_path
			notice = "Product Category was successfully created."
		end

		respond_to do |format|
			if @admin_product_category.save
				format.html { redirect_to( template, :notice => notice ) }
				format.xml  { render :xml => @admin_product_category, :status => :created, :location => @admin_product_category }
			else
				format.html { render template + '/new' } 
				format.xml  { render :xml => @admin_product_category.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /admin/product_categories/1
	# PUT /admin/product_categories/1.xml
	def update
		@admin_product_category = ProductCategory.find(params[:id])
		if params && params[:type] == "rifle"
			template = admin_rifle_category_path( @admin_product_category )
			notice = 'Rifle category was successfully updated.'
		else
			template = admin_product_category_path( @admin_product_category )
			notice = 'Product category was successfully updated.'
		end

		respond_to do |format|
			if @admin_product_category.update_attributes(params[:product_category])
				format.html { redirect_to( template, :notice => notice) }
				format.xml  { head :ok }
			else
				format.html { render ProductsLib.template "edit" }
				format.xml  { render :xml => @admin_product_category.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /admin/product_categories/1
	# DELETE /admin/product_categories/1.xml
	def destroy
		@admin_product_category = ProductCategory.find(params[:id])
		@admin_product_category.destroy

		if rifle_page?
			url = admin_rifle_categories_path
			notice = "Rifle"
		else
			url = admin_rifle_categories_path
			notice = "Product"
		end

		respond_to do |format|
			format.html { redirect_to( url, :notice => notice + " cateogry was successfully deleted.") }
			format.xml  { head :ok }
		end
	end

	private
	def setup
		@product_type = ProductsLib.setup( request.fullpath )
	end
end
