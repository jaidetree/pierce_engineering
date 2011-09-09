# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user = User.create  :first_name => 'Jay',
					:last_name => 'Zawrotny',
					:email => 'jay@aetkinz.com',
					:password => 'admin',
					:password_confirmation => 'admin'

navigation = Setting.create :key => 'navigation', 
							:value => [],
							:hidden => 1

general = Setting.create	:key => 'general', 
							:value => []

contact_info = Setting.create	:key => 'contact', 
								:value => []

products_cat = ProductCategory.create	:name => 'Products',
										:slug => 'products',
										:cat_type => 0

rifles_cat = ProductCategory.create		:name => 'Rifles',
										:slug => 'rifles',
										:cat_type => 1

