class AddFilenameToSource < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :filename, :string
  end
end
