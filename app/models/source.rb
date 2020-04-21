class Source < ApplicationRecord
  belongs_to :item
  belongs_to :attachment_file
  default_scope { where(deleted: false).order(:deprecated, created_at: :desc) }
  before_save :set_resource_data
  attr_accessor :uploaded_file
  has_paper_trail versions: { class_name: 'SourceVersion' }, 
    skip: [:deprecated, :approved, :item_id, :allow_download, :deleted]
  scope :actives, -> { where(deprecated: false) }

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
        if uploaded_file.size <= (400 * 1024 * 1024) # Max file size = 400 MB
          ActiveRecord::Base.transaction do
            require "zlib"
            attachment = AttachmentFile.new
            attachment.resource_binary_zip = Zlib::Deflate.deflate(uploaded_file.tempfile.read)
            attachment.mime_type = uploaded_file.content_type
            self.mime_type = attachment.mime_type
            attachment.filename = uploaded_file.original_filename
            attachment.save!
            self.attachment_file = attachment
          end
        else
          raise 'Attachment is too big'
        end
      end
    end
end
