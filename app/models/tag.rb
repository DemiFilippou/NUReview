class Tag < ApplicationRecord
  has_and_belongs_to_many :reviews
  validates :tag, uniqueness: true, presence: true
end
