class Admin::ProductCategoriesController < ApplicationController
  # GET /admin/product_categories
  # GET /admin/product_categories.xml
  def index
    @admin_product_categories = ProductCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_product_categories }
    end
  end

  # GET /admin/product_categories/1
  # GET /admin/product_categories/1.xml
  def show
    @admin_product_category = ProductCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_product_category }
    end
  end

  # GET /admin/product_categories/new
  # GET /admin/product_categories/new.xml
  def new
    @admin_product_category = ProductCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_product_category }
    end
  end

  # GET /admin/product_categories/1/edit
  def edit
    @admin_product_category = ProductCategory.find(params[:id])
  end

  # POST /admin/product_categories
  # POST /admin/product_categories.xml
  def create
    @admin_product_category = ProductCategory.new(params[:admin_product_category])

    respond_to do |format|
      if @admin_product_category.save
        format.html { redirect_to(@admin_product_category, :notice => 'Product category was successfully created.') }
        format.xml  { render :xml => @admin_product_category, :status => :created, :location => @admin_product_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_product_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/product_categories/1
  # PUT /admin/product_categories/1.xml
  def update
    @admin_product_category = ProductCategory.find(params[:id])

    respond_to do |format|
      if @admin_product_category.update_attributes(params[:admin_product_category])
        format.html { redirect_to(@admin_product_category, :notice => 'Product category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_product_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/product_categories/1
  # DELETE /admin/product_categories/1.xml
  def destroy
    @admin_product_category = ProductCategory.find(params[:id])
    @admin_product_category.destroy

    respond_to do |format|
      format.html { redirect_to(admin_product_categories_url) }
      format.xml  { head :ok }
    end
  end
end
