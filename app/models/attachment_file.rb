class AttachmentFile < ApplicationRecord
  has_one :source
  default_scope { select(:id, :filename, :mime_type) }

  def resource
    require "zlib"
    me = self.class.unscoped.select(:id, :resource_binary_zip).where(id: self.id).take
    if me.present?
      return Zlib::Inflate.inflate(me.resource_binary_zip)
    end
    nil
  end
end
