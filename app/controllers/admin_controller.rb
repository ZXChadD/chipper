class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
  end

    def is_admin?
      redirect_to new_user_session_path unless current_user.is_admin
    end
end
