class Party < ApplicationRecord
  validates :start_time, :date, :duration, presence: true

  belongs_to :movie
  has_many :parties_users, dependent: :destroy
  has_many :users, through: :parties_users

  def host
    users.joins(:parties_users).group(:id).where('parties_users.host = ?', true)
  end

  def guests
    users.joins(:parties_users).group(:id).where('parties_users.host = ?', false).order(:id => :desc) 
  end
  
end
