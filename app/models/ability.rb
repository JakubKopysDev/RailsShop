# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can %i[read create], CartItem
    can :read, Product
    can :destroy, CartItem, cart: { user_id: user.id }
  end
end
