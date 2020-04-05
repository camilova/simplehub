class AddMimeTypeToSources < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :mime_type, :string
  end
end
