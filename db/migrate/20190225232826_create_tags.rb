class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :tag
      t.timestamps
    end

    create_table :companies_tags, id: false do |t|
      t.belongs_to :company, index: true
      t.belongs_to :tag, index: true
    end

  end
end
