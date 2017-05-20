# frozen_string_literal: true

namespace :pictures do
  desc 'Reprocesses existing images'
  task reprocess_files: :environment do
    Picture.find_each do |picture|
      picture.file.recreate_versions! if picture.file?
    end
  end

  puts 'Reprocessed pictures'
end
