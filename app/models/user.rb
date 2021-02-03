class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_many :buddies, dependent: :destroy, class_name: :Friend
  has_many :friends, through: :buddies

  has_many :parties_users
  has_many :parties, through: :parties_users

  def hosted_parties
    parties_users.where(host: true).map do |parties_user|
      parties_user.party
    end
  end

  def invited_parties
    parties_users.where(host: false).map do |parties_user|
      parties_user.party
    end
  end
end
