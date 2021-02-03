class Party < ApplicationRecord
  has_many :movies
  has_many :parties_users
  has_many :users, through: :parties_users
end
