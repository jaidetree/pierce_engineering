class Admin::AdminController < ApplicationController
	before_filter :authenticate

	def index
		respond_to do |format|
			format.html # index.html.erb
			#format.xml  { render :xml => @products }
		end
	end
end
