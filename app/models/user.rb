class User < ApplicationRecord

	validates 	:name, presence: true, length: {maximum: 50}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates 	:email, presence: true,
					  	length: {maximum: 255},
					  	format: {with: VALID_EMAIL_REGEX},
					  	uniqueness: {case_sensitive: false}

	VALID_CONTACT_REGEX = /\b[7-9]{1}[0-9]{9}\b/
	validates 	:contact, presence: true,
				format: {with: VALID_CONTACT_REGEX}

	VALID_PASSWORD_REGEX = /((?=.*\d)(?=.*[a-z])(?=.*[@#$%]).{8,30})/
	validates 	:password, presence: true,
				length: {minimum: 8},
				format: {with: VALID_PASSWORD_REGEX}

	before_save {email.downcase!}

	has_secure_password

	# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end
