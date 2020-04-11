class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :title
      t.string :link
      t.binary :resource
      t.string :mime_type
      t.boolean :deprecated, default: false
      t.boolean :approved, default: true
      t.references :item, foreign_key: true
      t.boolean :allow_download, default: true

      t.timestamps
    end
  end
end
