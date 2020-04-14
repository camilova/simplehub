class Category < ApplicationRecord
  has_many :item_categories, dependent: :nullify
  has_many :items, through: :item_categories
  default_scope { order(:created_at) }
  scope :selectable, -> { where('id > ?', Category.default.id) }

  def self.default
    # First category will always be static and its defaults to "All"
    Category.find(1)
  end
end
