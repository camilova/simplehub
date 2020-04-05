class Source < ApplicationRecord
  has_many :order_sources, dependent: :destroy
  has_many :orders, through: :order_sourcescler
  default_scope { order(created_at: :desc) }
end
