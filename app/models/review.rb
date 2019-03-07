class Review < ApplicationRecord
  extend Enumerize
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  belongs_to :company
  has_many :votes
  has_many :voters, through: :votes, source: :user
  has_and_belongs_to_many :tags
  validates :position, presence: true
  belongs_to :position
  validates :semester, presence: true
  validates :year, presence: true
  validates :enjoyment, presence: true
  validates :learning, presence: true
  validates :recommend, presence: true
  validates :wage, :numericality => { :greater_than_or_equal_to => 0 }, allow_blank: true
  validates :enjoyment, :learning, :recommend, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10 }, allow_blank: true

  enumerize :semester, in: [:Spring, :Fall, :Summer]

  # total upvotes/downvotes score
  def recalculate_score(incoming_score)
    update(score: (votes.sum(:value) + incoming_score))
  end

  def user_vote(current_user)
    @vote = votes.find_by(user: current_user)
    if @vote
      @vote.value
    else
      0
    end
  end
end
