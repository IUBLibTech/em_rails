class User < ApplicationRecord

  # If importing data from the original database (rails db:migrate), you must first turn off all validation AND the
  # before_safe :encrypt_password callback or migrations related to User import will fail.
  attr_accessor :password
  attr_accessor :skip_username_validation
  validates :first_name, presence: true
  validates :last_name, presence: true
  # need to skip this validation when rehashing the password with bcrypt
  validate :user_email, unless: :skip_username_validation
  validate :password_length, if: :creating?
  validates :password, confirmation: true, if: :creating?
  validates :password_confirmation, presence: true, if: :creating?
  validate :user_agreed_to_eula

  def full_name
    "#{first_name}#{middle_name.blank? ? "" : " "+middle_name} #{last_name}"
  end

  # this cannot be utilized as a callback because there are 3 different instances where a User object is saved:
  # 1) creation, in which case user.password is available and should be hashed
  # 2) account activation, in which case the user.password IS NOT present and re-encrypting that password encrypts with nil
  # 3) password reset, in which case user.password is again present and should be hashed
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end

  def self.authenticate(email, password)
    # In the original java version of the app, passwords were stored as SHA1 hashes. This rails versions uses bcrypt
    # so check if (old) existing accounts have had their password hashes updated to bcrypt (user.password_converted).
    # If not, validate password against the stored SHA1 hash and if they are equal, rehash the provided password using
    # bcrypt and delete the old password.
    user = User.find_by "email = ?", email
    if user && user.password_converted && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    elsif user && !user.password_converted
      old = Digest::SHA1.hexdigest(password)
      if old == user.old_password_sha1
        user.password_salt = BCrypt::Engine.generate_salt
        user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
        user.password_converted = true
        user.old_password_sha1 = nil
        user.skip_username_validation = true
        user.save!
        user
      else
        nil
      end
    else
      nil
    end
  end

  private
  def user_agreed_to_eula
    errors.add(:base, "You must agree to the EULA to create an account") if self.agreed_to_eula != true
  end

  def user_email
    errors.add(:base, "An account with that email address already exists") if User.where(email: self.email).first&.email == self.email
  end

  def password_length
    errors.add(:base, "Password must be at least 12 characters long") if password.length < 12 || password_confirmation.length < 12
  end

  # since User.password and User.password_confirmation are NOT saved in the database, they will be nil. However, whenever a user needs
  # to modify themselves (password reset request, change of email address, etc), this validation should not take place. The only time
  # this validation holds is during the creation of a new user or when a user resets their password
  def creating?
    !password.nil? && !password_confirmation.nil?
  end

end
