class Order < ApplicationRecord
  has_many :sources, dependent: :nullify
  belongs_to :item
  default_scope -> { order(:deprecated, published_at: :desc) }
  scope :actives, -> { where(deprecated: false) }
  scope :deprecated, -> { where(deprecated: true) }
end
