class User < ApplicationRecord
    EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    validates :first_name, :last_name, :email, presence: true
    validates :password, :password_confirmation, presence: true, length: { minimum: 8 }, on: :create
    validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
    has_secure_password
    before_save :downcase_email
  
    has_many :groups, dependent: :destroy

    has_many :members, dependent: :destroy
    has_many :joined, through: :members, source: :group
        
    private
      def downcase_email
        self.email.downcase!
      end
  end
  

