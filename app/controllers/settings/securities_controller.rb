module Settings
  class SecuritiesController < SettingsController
    def show; end

    def update
      if current_user.update_with_password(user_params)
        bypass_sign_in(current_user)
        redirect_to(settings_security_path, notice: 'Password was successfully updated.')
      else
        render(:show)
      end
    end

    private

    def user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
  end
end
