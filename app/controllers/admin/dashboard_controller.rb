class Admin::DashboardController < ApplicationController

	def index
		respond_to do |format|
			format.html # index.html.erb
			#format.xml  { render :xml => @products }
		end
	end
	def show
		respond_to do |format|
			format.html # index.html.erb
			#format.xml  { render :xml => @products }
		end
	end
end
