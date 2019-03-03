class AddPositionTable < ActiveRecord::Migration[5.2]
  def change
    unless(table_exists? :positions) 
      create_table :positions do |t|
      t.string :title
      t.timestamps
      end
    end
    
    if (column_exists? :reviews, :position)
      remove_column :reviews, :position
    end

    add_reference :reviews, :position, index: true
  end

  
end
