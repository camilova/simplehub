class CreateOrdersOfItems < ActiveRecord::Migration[5.2]
  def change
    create_table :orders_of_items do |t|
      t.references :orders, foreign_key: true
      t.references :items, foreign_key: true

      t.timestamps
    end
  end
end
