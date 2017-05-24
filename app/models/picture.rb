# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :product, inverse_of: :pictures

  mount_uploader :file, FileUploader

  validates :product, presence: true
  validate :file_size_validation
  validates_integrity_of :file
  validates_processing_of :file

  private

  def file_size_validation
    errors[:file] << "should be less than 5MB" if file.size > 5.megabytes
  end
end
