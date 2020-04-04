class CreateSourcesOfOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :sources_of_orders do |t|
      t.references :sources, foreign_key: true
      t.references :orders, foreign_key: true

      t.timestamps
    end
  end
end
