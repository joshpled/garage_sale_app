class ChangeSoldColumnOnItemsTable < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :sold, false
  end
end
