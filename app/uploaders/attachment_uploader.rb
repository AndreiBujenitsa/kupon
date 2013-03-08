# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
   include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "uploads/#{Crypto.encrypt(model.id.to_s)}"
  end
  
  def move_to_store
    true
  end
  
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb, :if => :is_pic? do
    process :resize_to_fill => [60, 80]
  end
  
  version :pdf_thumb, :if => :is_pdf? do
    process :convert_and_scale => [60, 80, 'jpeg']
  end
  
  version :big_thumb, :if => :is_pic? do
    process :resize_to_fit => [240, 320]
  end
  
  version :big_pdf_thumb, :if => :is_pdf? do
    process :convert_and_scale => [240, 320, 'jpeg']
  end
  
  version :carousel_thumb, :if => :included_format? do
    process :convert_and_scale => [480, 600, 'jpeg']
  end
  
  def is_pic? data
    ['jpg', 'jpeg', 'gif', 'png'].include? data.file.split('.').last.downcase
  end
  
  def is_pdf? data
    'pdf' == data.file.split('.').last.downcase
  end
  
  def included_format? data
    is_pic?(data) || is_pdf?(data)
  end

  def convert_and_scale width, height, format
    store! file.file
    pdf = Magick::ImageList.new(@file.file)
    img = pdf.first
    File.unlink(@file.file)
    img.resize_to_fit! width, height
    img.write format + ":" + @file.file
    destroy_image(pdf)
    img
  end
  
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
end
