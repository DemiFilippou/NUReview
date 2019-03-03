class Review < ApplicationRecord
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"
    belongs_to :company
    has_and_belongs_to_many :tags
    validates :position, presence: true
    validates :semester, presence: true
    validates :year, presence: true
    validates :enjoyment, presence: true
    validates :learning, presence: true
    validates :recommend, presence: true
    validates :hourly_rate, :numericality => { :greater_than_or_equal_to => 0 }, allow_blank: true

    ONE_TO_TEN = (1..10).to_a
    enum enjoyment: ONE_TO_TEN, _prefix: true
    enum learning: ONE_TO_TEN, _prefix: true
    enum recommend: ONE_TO_TEN, _prefix: true

    def upvote

    end
end
