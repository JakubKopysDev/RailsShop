# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, [CartItem, Product]
    can :create, [CartItem, Review]
    can %i[destroy update], Review, user_id: user.id
    can :destroy, CartItem, cart: { user_id: user.id }
  end
end
