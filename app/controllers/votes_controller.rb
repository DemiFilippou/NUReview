class VotesController < ApplicationController
  def create
    @vote = Vote.find_by(user: current_user, review_id: vote_params[:review_id])

    if @vote
      @vote.assign_attributes(value: vote_params[:value])
    else
      @vote = Vote.new(vote_params.merge(
        {
          user: current_user
        }))
    end

    if @vote.save
      render json: @vote, include: {:review => {:only => :score}}
    else
      render json: {:errors => @vote.errors.full_messages}
    end
  end

  private
  def vote_params
    params.require(:vote).permit(:value, :review_id)
  end
end
