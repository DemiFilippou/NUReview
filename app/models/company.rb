class Company < ApplicationRecord
  has_many :reviews
  validates :name, uniqueness: true, presence: true

  def self.search(query)
    self.where("name LIKE ?", "%#{query}%").first(7)
  end
end
