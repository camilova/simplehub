class Item < ApplicationRecord
  has_many :orders_of_items, dependent: :destroy
end
