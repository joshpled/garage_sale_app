class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.string :category
      t.belongs_to :listing
      t.timestamps null: false
    end
  end
end
