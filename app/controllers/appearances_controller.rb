class AppearancesController < ApplicationController

  def index
    @appearances = Appearance.all
  end

  def new
    @appearance = Appearance.new
    @guest = Guest.find_by(name: params[:guest])
  end

  def create
    @guest = Guest.find_by(name: appearance_params[:guest])
    @episode = Episode.find_by(number: appearance_params[:episode])
    @appearance = Appearance.new(guest_id: @guest.id, episode_id: @episode.id, rating: appearance_params[:rating])
    @appearance.save
    redirect_to appearance_path(@appearance)
  end

  def show
    @appearance = Appearance.find(params[:id])
    @guest = Guest.find(@appearance.guest_id)
    @episode = Episode.find(@appearance.episode_id)
  end

  private

  def appearance_params
    params.require(:appearance).permit(:guest, :episode, :rating)
  end

end


# t.integer  "guest_id"
# t.integer  "episode_id"
# t.integer  "rating",     default: 5
