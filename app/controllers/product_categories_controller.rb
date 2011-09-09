class ProductCategoriesController < ApplicationController

  # GET /product_categories/1
  # GET /product_categories/1.xml
  def show
    @product_category = ProductCategory.find_by_slug(params[:id]) || ProductCategory.find(params[:id])
	@product_type = @product_category.cat_type == 1 ? "rifle" : "product"
	@title = @product_category.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_category }
    end
  end
end
