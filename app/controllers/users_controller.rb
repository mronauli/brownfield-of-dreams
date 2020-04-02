# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @github_info = GithubSearchFacade.new(current_user.token)
    @videos = UserVideo.order_bookmarked(current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'E-mail already exists'
      render :new
    end
  end

  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      @user.email_activate
      flash[:success] = 'Thank you! Your account is now activated.'
      redirect_to dashboard_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
