# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  session_token   :string
#


class User < ApplicationRecord
  validates :username, :session_token, :password_digest, presence: true
  validates :username, uniqueness: true
  after_initialize :ensure_session_token
  attr_reader :password


  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save
  end

  private
  def generate_session_token
    SecureRandom::urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= generate_session_token    
  end
end
