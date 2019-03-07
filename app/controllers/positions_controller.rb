class PositionsController < ApplicationController
  def index
    @positions = Position.all
    render json: @positions, only: [:id, :title]
  end
  
  def create
    @position = Position.new(position_params)
    if @position.save
      render json: @position, only: [:id, :title]
    else
        render json: {:errors => @position.errors.full_messages}, status: 422
    end
  end
  
  private
  def position_params
    params.require(:position).permit([:title])
  end
end
