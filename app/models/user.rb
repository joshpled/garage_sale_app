class User < ActiveRecord::Base
    has_many :listings
    has_many :items, through: :listings
    has_secure_password

  validates :first_name, :last_name, presence: true

    PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x

    validates :password, :presence => true,
                        :confirmation => true,
                        :length => {:within => 6..40},
                        format: { with: PASSWORD_FORMAT }, 
                        :on => :create
                        
    validates :password, :confirmation => true,
                        :length => {:within => 6..40},
                        format: { with: PASSWORD_FORMAT }, 
                        :allow_blank => false,
                        :on => :update

    validates :email, uniqueness: true,
                        format: { with: URI::MailTo::EMAIL_REGEXP } 

    validates :username, uniqueness: true, presence: true

end
