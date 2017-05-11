# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @resource = current_user
  end

  def update_profile
    @resource = current_user
    if @resource.update_attributes profile_params
      redirect_to :profile, notice: 'Profile updated'
    else
      render :profile
    end
  end

  private

  def profile_params
    params.require(:user).permit(:country, :city, :street, :post_code,
                                 :phone_number, :credit_card_number,
                                 :credit_card_sec, :exp_date)
  end
end
