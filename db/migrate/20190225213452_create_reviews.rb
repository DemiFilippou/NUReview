class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :company
      t.string :body
      t.string :position
      t.string :semester
      t.integer :year
      t.integer :enjoyment
      t.integer :learning
      t.integer :recommend
      t.boolean :anonymous
      t.timestamps
    end
  end
end
