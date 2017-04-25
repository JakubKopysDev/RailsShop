module Admin
  class UsersController < AdminController
    before_action :find_user, only: [:destroy]

    def index
      @users = User.paginate(page: params[:page], per_page: 6)
    end

    def new
      @user = User.new
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: 'User deleted.'
    end

    private

    def find_user
      @user = User.find(params[:id])
    end
  end
end
