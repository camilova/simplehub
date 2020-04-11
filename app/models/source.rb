class Source < ApplicationRecord
  belongs_to :item
  default_scope { where(deleted: false).order(created_at: :desc) }
  before_save :set_resource_data
  attr_accessor :uploaded_file

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

  private

    def set_resource_data
      if uploaded_file.present?
        require 'mime/types'
        tempfile = uploaded_file.tempfile
        mime_type = MIME::Types.type_for(tempfile.path).first.content_type
        self.resource = tempfile.read
        self.mime_type = mime_type
      end
    end
end
