class UsersController < ApplicationController
  def main
    @users = User.all
  end
end
