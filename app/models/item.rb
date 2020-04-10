class Item < ApplicationRecord
  has_many :orders, dependent: :nullify
  has_many :item_categories
  has_many :categories, through: :item_categories
end
