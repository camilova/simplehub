class Source < ApplicationRecord
  has_many :source_of_orders, dependent: :destroy
end
