class User < ActiveRecord::Base
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, length: { minimum: 3 }
  
  def self.authenticate_with_credentials(email, password)
    authUser = User.find_by(email: email.strip.downcase)
    if !authUser.blank? && authUser.authenticate(password)
      return authUser  
    else
      return nil
    end
  end
  
end
