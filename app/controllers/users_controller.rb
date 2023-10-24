# frozen_string_literal: true

# Controllers users
class UsersController < ApplicationController
  def new; end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to register_path
      flash[:alert] = "Error: #{error_message(user.errors)}"
    end
  end

  def show
    # require 'pry';binding.pry
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:alert] = "You must be registered and logged in to access your dashboard."
      redirect_to '/'
    end
  end

  def discover
    @user = User.find(session[:user_id])
  end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to dashboard_path
    else
      flash[:error] = "Your credentials are incorrect."
      redirect_to login_path
    end
  end

  def logout_user
    session.delete(:user_id)
    redirect_to '/'
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
