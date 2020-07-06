class DropDateColumnFromListingsTable < ActiveRecord::Migration
  def change
    remove_column :listings, :date
  end
end
