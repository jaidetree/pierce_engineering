class PagesController < ApplicationController

	# GET /
	def index
		@products = Product.joins( :product_category ).where( 'product_categories.cat_type' => 1 ).limit(5).order('created_at DESC')
		@news = News.order('created_at DESC').limit(5)

		respond_to do |format|
			format.html # index.html.erb
			#format.xml  { render :xml => @products }
		end
	end

  # GET /slug.html
  def show
    @page = Page.find_by_slug(params[:slug])
	@title = @page.name

    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
