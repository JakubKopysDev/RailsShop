# frozen_string_literal: true
# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :medium do
    process resize_to_fill: [320, 180]
  end

  def extension_white_list
    %w[jpg jpeg png]
  end

  def default_url(*)
    '/images/fallback/' + [version_name, 'def.jpg'].compact.join('_')
  end
end
