class Item < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  has_many :orders, through: :item_orders
  has_many :item_categories
  has_many :categories, through: :item_categories
end
