class VideosController < ApplicationController
  def index
    videos = Video.order(:title).as_json(only: [:id, :title,
      :release_date, :available_inventory])
    render json: videos, status: :ok
  end

  def show
    video = Video.find_by(id: params[:id])
    
    if video.nil?
      render json: {
        "errors": ["Not Found"]},
        status: :not_found
        return
    end

    render json: video.as_json(only: [:title, :overview, :release_date, :total_inventory, :available_inventory]), status: :ok
  end

  def create
  end

  private
  
  def video_params
    params.permit(:title, :overview, :release_date, :available_inventory)
  end
end

