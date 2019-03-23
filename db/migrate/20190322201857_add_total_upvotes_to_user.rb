class AddTotalUpvotesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_upvotes, :integer, default: 0
  end
end
