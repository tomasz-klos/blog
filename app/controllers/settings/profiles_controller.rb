module Settings
  class ProfilesController < SettingsController
    def show; end

    def update
      if current_user.update(profile_params)
        redirect_to(settings_profile_path, notice: 'Profile was successfully updated.')
      else
        render(:show)
      end
    end

    private

    def profile_params
      params.require(:user).permit(:name, :email)
    end
  end
end
