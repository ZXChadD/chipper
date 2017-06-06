class UsersController < ApplicationController
  def show
    User.all
  end

end
