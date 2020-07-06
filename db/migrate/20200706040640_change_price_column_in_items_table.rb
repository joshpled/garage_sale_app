class ChangePriceColumnInItemsTable < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :price, :decimal, :precision => 6, :scale => 2
  end 
end
