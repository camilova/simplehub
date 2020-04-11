class AddDeleteToSources < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :deleted, :boolean, default: false
  end
end
