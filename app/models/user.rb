class User < ApplicationRecord
  include BCrypt
  has_many :reviews
  has_secure_password
  validates :email, uniqueness: true, presence: true
end
