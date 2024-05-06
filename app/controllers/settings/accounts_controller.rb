module Settings
  class AccountsController < SettingsController
    def show; end

    def destroy
      current_user.destroy

      redirect_to(posts_root_path, notice: 'Account was successfully deleted.')
    end
  end
end
