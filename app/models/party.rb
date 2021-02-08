class Party < ApplicationRecord
  validates :start_time, :date, :duration, presence: true

  belongs_to :movie
  has_many :parties_users, dependent: :destroy
  has_many :users, through: :parties_users
end
