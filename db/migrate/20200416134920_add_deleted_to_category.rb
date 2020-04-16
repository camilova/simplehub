class AddDeletedToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :deleted, :boolean, default: false
  end
end
