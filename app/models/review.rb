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
  validates :year, presence: true, :numericality => { :greater_than_or_equal_to => 2000, :less_than_or_equal_to => Time.current.year }
  validates :enjoyment, presence: true
  validates :learning, presence: true
  validates :recommend, presence: true
  validates :wage, :numericality => { :greater_than_or_equal_to => 0 }, allow_blank: true
  validates :enjoyment, :learning, :recommend, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5 }, allow_blank: true

  # users automatically upvote their own post
  after_create :upvote_post

  enumerize :semester, in: [:Spring, :Fall, :Summer]

  def upvote_post
    Vote.create(user_id: self.user_id, review_id: self.id, value: 1)
  end

  # total upvotes/downvotes score
  def recalculate_score(incoming_score)
    update(score: (votes.sum(:value) + incoming_score))
    self.user.update(total_upvotes: (self.user.reviews.sum(:score)))
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
