class TagsController < ApplicationController
  def index
    @tags = Tag.all
    render json: @tags, only: [:tag, :id]
  end

  private
  def tag_params
    params.require(:tag).permit!
  end
end
