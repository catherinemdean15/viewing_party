class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_many :buddies, dependent: :destroy, class_name: :Friend
  has_many :friends, through: :buddies
end
