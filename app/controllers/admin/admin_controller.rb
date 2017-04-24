module Admin
  class AdminController < ApplicationController
    before_action :authorize_admin

    private

    def authorize_admin
      redirect_to root_path, alert: 'Not authorized' unless current_user.admin?
    end
  end
end
