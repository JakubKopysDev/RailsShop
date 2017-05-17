# frozen_string_literal: true

class User < ApplicationRecord
  COUNTRY_CODES = ISO3166::Country.codes

  mount_uploader :avatar, AvatarUploader

  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart
  has_many :reviews, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]

  validates :name, length: { in: 4..25 }, uniqueness: true
  validates :country, allow_blank: true, inclusion:
  { in: COUNTRY_CODES, message: '%{value} is not a valid Country Code' }
  validates :city, :street, length: { in: 3..50 }, allow_blank: true
  validates :post_code, zipcode: { country_code_attribute: :country },
                        allow_blank: true
  validates :phone_number, format: { with: /(?:\+?|\b)[0-9]{10}\b/ },
                           length: { in: 12..15 }, allow_blank: true
  validates :credit_card_number, length: { in: 9..25 }, allow_blank: true
  validates :credit_card_sec, length: { is: 3 }, allow_blank: true
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  attr_accessor :login

  # overwrite Devise authentication - allow login using email or name
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h)
        .find_by(['lower(name) = :value OR lower(email) = :value',
                  { value: login.downcase }])
    elsif conditions.key?(:name) || conditions.key?(:email)
      find_by conditions.to_h
    end
  end
end
