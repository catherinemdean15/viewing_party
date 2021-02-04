class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  has_many :friends, foreign_key: :friend1_id
  has_many :followings, through: :friends, source: :friend2

  has_many :parties_users
  has_many :parties, through: :parties_users

  def invited_parties
    parties.joins(:parties_users).where('parties_users.host = false')
  end

  def hosted_parties
    parties.joins(:parties_users).where('parties_users.host = true')
  end

  def has_no_followers?
    followings.empty?
  end
end
