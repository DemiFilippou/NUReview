class AddHourlyRateAndScoreToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :hourly_rate, :integer
    add_column :reviews, :score, :integer, default: 0
  end
end
