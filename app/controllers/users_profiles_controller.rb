class UsersProfilesController < ApplicationController
  def show
    @user = User.friendly.find(params[:slug])
    @posts = @user.posts.published
    @comments = Comment.where(user: @user)
  end
end
