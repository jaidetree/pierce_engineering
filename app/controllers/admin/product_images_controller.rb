class Admin::ProductImagesController < ApplicationController
	
  include Photos

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
    @product = Product.find(params[:product_id])
    @product_image = @product.product_images.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_image }
    end
  end

  # GET /product_images/1/edit
  def edit
    @product = Product.find(params[:id])
    @product_image = @product.product_images.new
  end

  # POST /product_images
  # POST /product_images.xml
  def create
	@product = Product.find( params[:product_id] )
    @product_image = @product.product_images.new( params[:product_image] )

	@product_image.images = Photos.upload params[:product_image][:file]


    respond_to do |format|
      if @product_image.save
        format.html { redirect_to( edit_admin_products_product_image( @product_image ), :notice => 'Product image was successfully created.') }
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
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_images/1
  # DELETE /product_images/1.xml
  def destroy
    @product_image = ProductImage.find(params[:id])
    @product_image.destroy

    respond_to do |format|
      format.html { redirect_to(product_images_url) }
      format.xml  { head :ok }
    end
  end
end
