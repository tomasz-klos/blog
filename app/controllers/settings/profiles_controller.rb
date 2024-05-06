module Settings
  class ProfilesController < SettingsController
    def show; end

    def update
      puts "profile_params: #{profile_params}"
      puts "current_user: #{current_user.inspect}"
      if current_user.update(profile_params)
        redirect_to(settings_profile_path, notice: 'Profile was successfully updated.')
      else
        puts "Errors: #{current_user.errors.full_messages}"
        render(:show)
      end
    end

    private

    def profile_params
      params.require(:user).permit(:name, :email)
    end
  end
end
