# frozen_string_literal: true

class Categorization < ApplicationRecord
  belongs_to :product
  belongs_to :category
end
