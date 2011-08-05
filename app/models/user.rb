require 'bcrypt'

class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessor :current_password
	include BCrypt

	validates :email, :presence => true, :uniqueness => true
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :password, :presence => true, :confirmation => true, :if => :password_required?

    has_many :product_categories
	has_many :products, :through => :product_categories
	has_many :news

	before_save :encrypt_new_password

	def current_password
		@current_password || Password.new(hashed_password)
	end

	def self.authenticate( email, password )
		user = find_by_email( email )
		return ( user && user.authenticated?( password ) ) ? user : false
	end

	def authenticated?(password)
		self.current_password == self.salt + password
	end

	def full_name
		self.first_name + " " + self.last_name
	end

	def identity
		self.first_name + " ( " + self.email + " )"
	end

	protected
		def encrypt_new_password
			return if password.blank?
			self.salt = encrypt( Engine.generate_salt(2) )
			self.hashed_password = encrypt( self.salt + password )
		end

		def password_required?
			hashed_password.blank? || password.present?
		end

		def encrypt( string )
            Password.create( string )
		end
end
