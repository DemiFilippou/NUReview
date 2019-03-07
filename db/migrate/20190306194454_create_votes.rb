class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :value, default: 0
      t.belongs_to :review, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
