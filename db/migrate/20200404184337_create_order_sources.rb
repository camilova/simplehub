class CreateOrderSources < ActiveRecord::Migration[5.2]
  def change
    create_table :order_sources do |t|
      t.references :order
      t.references :source

      t.timestamps
    end
  end
end
