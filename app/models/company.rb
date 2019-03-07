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

    if @user
      @company_json['reviews'].each do |review|
        @review = Review.find(review['id'])
        review['user_vote'] = @review.user_vote(@user)

        if review['anonymous']
          review.delete("user_id")
          review.delete("user")
        end
      end
    end


    @company_json
  end
end
