class SettingsController < ApplicationController
  before_action(:authenticate_user!)

  layout('settings')
end
