module Dashboard
  class PagesController < ApplicationController
    layout('dashboard')

    def dashboard
      render :dashboard
    end
  end
end
