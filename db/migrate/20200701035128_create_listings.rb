class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.datetime :date
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
