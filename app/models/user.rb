# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]
  validates :name, length: { in: 4..25 }, uniqueness: true
  attr_accessor :login
  has_one :cart
  has_many :cart_items, through: :cart

  # overwrite Devise authentication - allow login using email or name
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      find_by(conditions.to_h)
        .find_by(['lower(name) = :value OR lower(email) = :value',
                  { value: login.downcase }])
    elsif conditions.key?(:name) || conditions.key?(:email)
      find_by conditions.to_h
    end
  end
end
