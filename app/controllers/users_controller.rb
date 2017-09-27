class UsersController < ApplicationController

  before_action :ensure_signup_complete

  def finish_signup
    @user = User.find(params[:id])
    @user.update(user_params) if request.patch? && params[:user]
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
