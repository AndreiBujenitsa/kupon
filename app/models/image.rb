class Image < ActiveRecord::Base
  attr_accessible :attachment, :deal_id
  
  before_destroy :remember_id
  after_destroy :remove_id_directory

  mount_uploader :attachment, AttachmentUploader
  
  
  def thumb_url
    if self.attachment.is_pic? self.attachment.file
      self.attachment.thumb.url
    elsif self.attachment.is_pdf? self.attachment.file
      self.attachment.pdf_thumb.url
    elsif self.attachment.path.split('.').last.downcase == 'doc'
      '/assets/file_icon_doc.gif'
    else
      '/assets/icon_file.gif'
    end
  end
  
  def big_thumb_url
    if self.attachment.is_pic? self.attachment.file
      self.attachment.big_thumb.url
    elsif self.attachment.is_pdf? self.attachment.file
      self.attachment.big_pdf_thumb.url
    elsif self.attachment.path.split('.').last.downcase == 'doc'
      '/assets/file_icon_doc.gif'
    else
      '/assets/icon_file.gif'
    end
  end
  
  protected
  def remember_id
    @id = id
  end

  def remove_id_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/#{Crypto.encrypt(@id.to_s)}", :force => true)
  end
end
