class AddSoldColumnToItemsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sold, :boolean
  end
end
