class AddDescriptionColumnToListingsTable < ActiveRecord::Migration
  def change
    add_column :listings, :description, :string
  end
end
