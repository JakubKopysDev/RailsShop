# frozen_string_literal: true

module Macros
  def login_admin
    before do
      @request.env['devise.mapping'] = Devise.mappings[:admin_user]
      admin = FactoryGirl.create(:admin_user)
      sign_in admin
    end
  end

  def login_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user
    end
  end
end
