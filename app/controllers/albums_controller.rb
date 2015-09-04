class AlbumsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @albums = @user.albums  
  end
end
