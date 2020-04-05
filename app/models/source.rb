class Source < ApplicationRecord
  has_many :order_sources, dependent: :destroy
  has_many :orders, through: :order_sourcescler
  default_scope { order(created_at: :desc) }

  def video?
    mime_type.present? && mime_type.include?('video')
  end

  def audio?
    mime_type.present? && mime_type.include?('audio')
  end

  def image?
    mime_type.present? && mime_type.include?('image')
  end

  def pdf?
    mime_type.present? && mime_type.include?('pdf')
  end

  def streaming?
    video? || audio?
  end
end
