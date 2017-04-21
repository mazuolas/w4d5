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

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(username:"mark", password: "password") }

  describe 'validations' do
    it { should validate_presence_of (:username) }
    it { should validate_presence_of (:password_digest) }
    it { should validate_uniqueness_of (:username) } # => records needed in DB
  end

  describe 'associations' do
  end

  describe 'class methods' do
    it "finds by credentials" do
      user.save
      expect(User.find_by_credentials("mark", "password")).to eq(user)
    end

    it "resets session token" do
      previous_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(previous_session_token)
    end
  end

  describe 'instance methods' do
    it "sets a password" do
      expect(user.password).to eq("password")
      expect(BCrypt::Password.new(user.password_digest).is_password?("password")).to be true
    end

    it "checks passwords" do
      expect(user.is_password?("password")).to be true
      expect(user.is_password?("wrongpasword")).to be false
    end
  end

end
