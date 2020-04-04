class Order < ApplicationRecord
  has_many :sources_of_orders, dependent: :destroy
  has_many :orders_of_items, dependent: :destroy
end
