class DropDateColumnFromListingsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :date
  end
end
