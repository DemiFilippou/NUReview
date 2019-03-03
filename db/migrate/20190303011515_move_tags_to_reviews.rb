class MoveTagsToReviews < ActiveRecord::Migration[5.2]
  def change
    drop_table :companies_tags

    create_table :reviews_tags, id: false do |t|
      t.belongs_to :review, index: true
      t.belongs_to :tag, index: true
    end
  end
end
