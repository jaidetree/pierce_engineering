class Admin::NewsController < ApplicationController
  # GET /news
  # GET /news.xml
  def index
    @news = News.order("created_at DESC").all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/1
  # GET /news/1.xml
  def show
    @story = News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /news/new
  # GET /news/new.xml
  def new
	@products = Product.find_all_by_type(0)
	@rifles = Product.find_all_by_type(1)
    @story = News.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /news/1/edit
  def edit
	@products = Product.find_all_by_type(0)
	@rifles = Product.find_all_by_type(1)
    @story = News.find(params[:id])
  end

  # POST /news
  # POST /news.xml
  def create
	@user = current_user

	if params[:news][:products].nil? 
		params[:news][:products] = []
	end

    @news = @user.news.new(params[:news])

    respond_to do |format|
      if @news.save
        format.html { redirect_to( [:admin, @news], :notice => 'News was successfully created.') }
        format.xml  { render :xml => @news, :status => :created, :location => @news }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news/1
  # PUT /news/1.xml
  def update
    @news = News.find(params[:id])

	if params[:news][:products].nil? 
		params[:news][:products] = []
	end

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to( [:admin, @news], :notice => 'News was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to(admin_news_index_url) }
      format.xml  { head :ok }
    end
  end
end
