class Review < ApplicationRecord
    belongs_to :user, :class_name => "User", :foreign_key => "author_id"
    belongs_to :company
    has_and_belongs_to_many :tags
end
