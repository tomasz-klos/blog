class UsersProfilesController < ApplicationController
  def show
    @user = User.find_by(name: params[:name])
    @posts = @user.posts.published
  end
end
