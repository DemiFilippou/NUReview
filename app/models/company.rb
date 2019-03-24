class Company < ApplicationRecord
  has_many :reviews
  validates :name, uniqueness: true, presence: true

  def self.search(query)
    self.where("name LIKE ?", "%#{query}%").first(7)
  end


  # in the future i would like to change how this is serialized completely to avoid
  # manipulating the JSON and doing extra queries, but for now this will have to do
  def as_json(options = { })
    @company_json = super
    @user = options[:current_user]

    unless @user
      return @company_json
    end

    reviews_json = []
    @company_json['reviews'].each do |review|
      @review = Review.find(review['id'])
      reviews_json << @review.as_json(:current_user => @user, include: options[:include][:reviews][:include])
    end

    @company_json.delete('reviews')
    @company_json['reviews'] = reviews_json

    @company_json
  end
end
