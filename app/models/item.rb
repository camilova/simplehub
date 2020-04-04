class Item < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  has_many :orders, through: :item_orders
end
