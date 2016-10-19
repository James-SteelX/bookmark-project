require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource

  attr_accessor :password_confirmation
  attr_reader :password, :email

  property :id, Serial
  property :email, String, :required => true, :unique => true
  property :password_digest, Text

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, :as => :email_address
  validates_uniqueness_of :email

end
