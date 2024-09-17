class UsersController < ApplicationController
  
  def show
    @user = User.find_by!(username: params.fetch(:username))
  end

  def feed
    @user = current_user
  end

  def discover
    @user = current_user
  end

  def followers
    @user = User.find_by!(username: params.fetch(:username))
  end
  
  def following
    @user = User.find_by!(username: params.fetch(:username))
  end

  def following
    @user = User.find_by!(username: params.fetch(:username))
  end

end