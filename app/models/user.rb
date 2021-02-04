class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_many :friendships
  has_many :friends, through: :friendships, :source => :friend
end
