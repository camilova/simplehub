class AddFieldsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :published_at, :date
    add_column :orders, :deprecated, :boolean, default: false
    add_column :orders, :deprecated_at, :date
  end
end
