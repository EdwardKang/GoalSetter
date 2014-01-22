require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :password, :username
  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_digest, presence: true

  has_many(
  :goals,
  class_name: "Goal",
  foreign_key: :user_id,
  primary_key: :id)

  has_many(
    :cheers,
    class_name: 'Cheer',
    foreign_key: :user_id,
    primary_key: :id
  ) do
      def today
        where(:created_at => (Time.now.beginning_of_day..Time.now))
      end
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    if user && user.is_password?(password)
      return user
    else
      return nil
    end

  end

  def reset_token
    self.update_attribute(:token, SecureRandom::urlsafe_base64(16))
    self.save
    self.token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


end
