class PagesController < ApplicationController
	# GET /
	def index
		#@products = Product.all

		respond_to do |format|
			format.html # index.html.erb
			#format.xml  { render :xml => @products }
		end
	end

end
