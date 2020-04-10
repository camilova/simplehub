class AddDeprecatedToSources < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :deprecated, :boolean, default: false
  end
end
