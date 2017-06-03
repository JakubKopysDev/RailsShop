# frozen_string_literal: true

class Ticket < ApplicationRecord
  # TODO: eliminate EMAIL REGEX duplication
  EMAIL_REGEX   = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  belongs_to :user

  validates :content, length: { in: 6..1000 }
  validates :name, length: { in: 4..25 }
  validates :email, format: { with: EMAIL_REGEX }
end
