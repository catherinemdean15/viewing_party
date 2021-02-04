class Party < ApplicationRecord 
  belongs_to :movie
  has_many :parties_users
  has_many :users, through: :parties_users
end