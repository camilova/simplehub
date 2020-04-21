class Item < ApplicationRecord
  belongs_to :item
  has_many :items, dependent: :nullify
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :sources, dependent: :nullify
  default_scope -> { where(deleted: false).
    order(:deprecated, published_at: :desc, created_at: :desc) }
  scope :actives, -> { where(deprecated: false) }
  scope :deprecated, -> { where(deprecated: true) }
  scope :main, -> { where(item: nil) }
  after_save :set_deprecated_on_sources

  def active_sources_count
    sources.actives.count + (items.sum do |i| i.sources.actives.count end)
  end

  def main?
    items.any? || item.nil?
  end

  private

    def set_deprecated_on_sources
      sources.each do |source|
        source.deprecated = deprecated
        source.save!
      end
    end
end
