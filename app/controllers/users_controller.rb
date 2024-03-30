class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_without_password(user_params)
    redirect_to mypage_users_url
  end

  def mypage
    @user = current_user
  end
  
  def edit_address
    @user = current_user
  end
  
  private
    def user_params
      params.permit(:name, :email, :phone, :password, :password_confirmation)
    end
end
