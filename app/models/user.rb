class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
            # format: {with: /^\w{3,20}@\w{3,20}.\w{3}/, message: 'Invalid email'}
  validates :password, presence: true, confirmation: true

  has_many :friends, dependent: :destroy, foreign_key: :friend1_id
  has_many :followings, dependent: :destroy, through: :friends, source: :friend2

  has_many :parties_users, dependent: :destroy
  has_many :parties, dependent: :destroy, through: :parties_users

  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end
  
  def invited_parties
    parties.joins(:parties_users).where('parties_users.host = false').uniq
  end

  def hosted_parties
    parties.joins(:parties_users).where('parties_users.host = true').uniq
  end

  def no_followers?
    followings.empty?
  end
end
