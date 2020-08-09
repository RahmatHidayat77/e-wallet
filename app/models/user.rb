class User < ApplicationRecord
  has_secure_password

  has_many :user_balances, foreign_key: :user_id

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
