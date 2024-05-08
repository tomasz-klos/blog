class UsersProfilesController < ApplicationController
  def show
    @user = User.friendly.find(params[:slug])
    @posts = @user.posts.published
  end
end
