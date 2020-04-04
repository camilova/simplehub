class Order < ApplicationRecord
  has_many :order_sources, dependent: :destroy
  has_many :item_orders, dependent: :destroy
  has_many :sources, through: :order_sources
  has_many :items, through: :item_orders
end
