class CreateSourceVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :source_versions do |t|
      t.string   :item_type, {:null=>false}
      t.integer  :item_id,   null: false, limit: 8
      t.string   :event,     null: false
      t.string   :whodunnit
      t.json     :object
      t.json     :object_changes

      t.timestamps
    end
  end
end
