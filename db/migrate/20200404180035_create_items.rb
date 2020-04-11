class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.string :description
      t.date :published_at
      t.boolean :deprecated, default: false
      t.date :deprecated_at
      t.boolean :approved, default: true
      t.references :item
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
