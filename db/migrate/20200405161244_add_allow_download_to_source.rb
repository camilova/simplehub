class AddAllowDownloadToSource < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :allow_download, :boolean, default: true
  end
end
