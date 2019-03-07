class User < ApplicationRecord
  include BCrypt
  has_many :reviews
  has_many :votes
  has_many :voted_posts, through: :votes, source: :review
  has_secure_password
  validates :email, uniqueness: true, presence: true,
    format: { with: /\b[A-Z0-9._%a-z\-]+@husky\.neu\.edu\z/,
              message: "must be @husky.neu.edu" }
  validates :password, length: { in: 6..20 }, presence: true
end
