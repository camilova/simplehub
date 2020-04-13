class AddResource64ToSource < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :resource64, :text
    rename_column :sources, :resource, :resource_binary
  end
end
