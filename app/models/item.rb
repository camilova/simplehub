class Item < ApplicationRecord
  has_many :items, dependent: :nullify
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :sources, dependent: :nullify
  belongs_to :item
  default_scope -> { where(deleted: false).order(:deprecated, published_at: :desc) }
  scope :actives, -> { where(deprecated: false) }
  scope :deprecated, -> { where(deprecated: true) }
  scope :main, -> { where(item: nil) }
end
