class Admin::PagesController < ApplicationController
  # GET /admin/pages
  # GET /admin/pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /admin/pages/1
  # GET /admin/pages/1.xml
  def show
    @page = Page.find_by_slug(params[:id]) || Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /admin/pages/new
  # GET /admin/pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /admin/pages/1/edit
  def edit
    @page = Page.find_by_slug(params[:id]) || Page.find(params[:id])
  end

  # POST /admin/pages
  # POST /admin/pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to( admin_page_path( @page ), :notice => 'Page was successfully created.') }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/pages/1
  # PUT /admin/pages/1.xml
  def update
    @page = Page.find_by_slug(params[:id]) || Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to( [:admin, @page], :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pages/1
  # DELETE /admin/pages/1.xml
  def destroy
    @page = Page.find_by_slug(params[:id]) || Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_pages_url, :notice => "Page was successfully deleted." ) }
      format.xml  { head :ok }
    end
  end
end
