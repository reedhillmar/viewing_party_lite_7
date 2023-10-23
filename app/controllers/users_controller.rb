# frozen_string_literal: true

# Controllers users
class UsersController < ApplicationController
  def new; end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to user_path(user)
    else
      redirect_to register_path
      flash[:alert] = "Error: #{error_message(user.errors)}"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def discover
    @user = User.find(params[:user_id])
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
