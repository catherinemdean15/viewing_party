class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, dependent: :destroy, class_name: 'User'
end
