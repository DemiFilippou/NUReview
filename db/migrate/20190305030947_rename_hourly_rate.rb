class RenameHourlyRate < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :hourly_rate, :wage
  end
end
