class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :value, :numericality => { :only_integer => true, :greater_than_or_equal_to => -1, :less_than_or_equal_to => 1 }
   before_create :recalculate_review_score_create
   before_update :recalculate_review_score_update
   before_destroy :recalculate_review_score_destroy

  def recalculate_review_score_create
    # when we create a new vote, we just want to add the new value to the score
    review.recalculate_score(value)
  end

  def recalculate_review_score_update
    # when we edit an existing vote, we want to subtract the old value and add the new one
    review.recalculate_score(-value_was + value)
  end

  def recalculate_review_score_destroy
    # and finally, when we destroy a vote, we want to get rid of its value from the total score
    review.recalculate_score(0-value)
  end
end
