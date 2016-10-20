require 'bcrypt'

class User
	include DataMapper::Resource

	attr_reader :password, :email
	attr_accessor :password_confirmation

	property :id, Serial
	property :email, String, :required => true
	property :password_digest, Text

	validates_confirmation_of :password
	validates_presence_of :email
	validates_format_of :email, :as => :email_address

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

end
