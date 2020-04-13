class Source < ApplicationRecord
  belongs_to :item
  default_scope { where(deleted: false).order(:deprecated, created_at: :desc) }
  before_save :set_resource_data
  attr_accessor :uploaded_file
  has_paper_trail versions: { class_name: 'SourceVersion' }, 
    skip: [:resource_binary, :deprecated, :approved, :item_id, :allow_download, :deleted]

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

  def resource
    require 'base64'
    self.resource_binary || (Base64.decode64(self.resource64) if self.resource64.present?)
  end

  private

    def set_resource_data
      if uploaded_file.present?
        require 'mime/types'
        require 'base64'
        tempfile = uploaded_file.tempfile
        mime_type_options = [MIME::Types.type_for(tempfile.path)].flatten
        if mime_type_options.count > 1
          mime_type = Mime::Type.lookup_by_extension(tempfile.path.split('.').last).to_s
        else
          mime_type = mime_type_options.first.to_s
        end
        self.resource_binary = tempfile.read
        self.resource64 = Base64.encode64(self.resource_binary)
        self.mime_type = mime_type
      end
    end
end
