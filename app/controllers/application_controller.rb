class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    return unless current_user

    Current.user = current_user
  end
end
