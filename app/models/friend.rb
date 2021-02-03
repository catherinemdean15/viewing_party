class Friend < ApplicationRecord
  belongs_to :user
  has_many :friends, dependent: :destroy, class_name: 'User', foreign_key: :id
end
