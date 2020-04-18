class CreateAttachmentFiles < ActiveRecord::Migration[5.2]
  def change
    ActiveRecord::Base.transaction do
      create_table :attachment_files do |t|
        t.binary :resource_binary_zip
        t.string :mime_type
        t.string :filename

        t.timestamps
      end
      add_reference :sources, :attachment_file, foreign_key: true, index: true
      # Move data from source to attachment before
      Source.where.not(resource_binary: nil).each do |source|
        attachment = AttachmentFile.new
        attachment.resource_binary_zip = source.resource_binary
        attachment.mime_type = source.mime_type
        attachment.filename = source.filename
        attachment.save!
        source.attachment_file = attachment
        source.save!
      end
      # Remove unused columns of sources
      remove_column :sources, :resource_binary
      remove_column :sources, :resource64
      remove_column :sources, :filename
    end
  end
end
