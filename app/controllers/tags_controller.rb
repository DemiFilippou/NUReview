class TagsController < ApplicationController
  def index
    @tags = Tag.all
    render json: @tags
  end

  private
  def tag_params
    params.require(:tag).permit!
  end
end
