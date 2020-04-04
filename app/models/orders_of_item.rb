class OrdersOfItem < ApplicationRecord
  belongs_to :orders
  belongs_to :items
end
