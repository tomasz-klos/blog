class Common::Likes::Component < ApplicationComponent
  option :target
  option :path
  option :likes
  option :current_user

  def liked_by_current_user?
    return false unless current_user

    likes.exists?(user: current_user)
  end
end
