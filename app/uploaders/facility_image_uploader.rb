class FacilityImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # Large size
  process resize_to_limit: [1200, 1200]

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :preview do
    process resize_to_fit: [300, 2000]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    original_filename if original_filename
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def size_range
    1..10.megabytes
  end

end
