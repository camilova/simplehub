class CreateItemOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :item_orders do |t|
      t.reference :item
      t.reference :order

      t.timestamps
    end
  end
end
