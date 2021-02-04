class Friend < ApplicationRecord
  belongs_to :friend1, class_name: :User
  belongs_to :friend2, class_name: :User
  # has_many :friends, dependent: :destroy, class_name: 'User', foreign_key: :id
end
