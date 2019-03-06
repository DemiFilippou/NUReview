class ReviewsController < ApplicationController
  before_action :find, only: [:update, :show, :upvote, :downvote]

  def create
    if params[:company_id]
      @review = Review.new(review_params.merge(
        {
          user: current_user,
          company_id: params[:company_id]
        }))
    else
      @review = Review.new(review_params.merge(
        {
          user: current_user
        }))
    end

    if @review.save
      show
    else
      render json: {:errors => @review.errors.full_messages}
    end
  end

  # update a user's review
  def update
    if @review.user == current_user
      if @review.update(review_params)
        show
      else
        render json: {:errors => @review.errors.full_messages}
      end
      render json: { :errors => "You are not authorized to do this." }
    end
  end

  def upvote
    if @review
      @review.upvote
      if @review.save
        show
      else
        render json: {:errors => @review.errors.full_messages}
      end
    else
      render json: {:errors => "No review found."}
    end
  end

  def downvote
    if @review
      @review.downvote
      if @review.save
        show
      else
        render json: {:errors => @review.errors.full_messages}
      end
    else
      render json: {:errors => "No review found."}
    end
  end

  def show
    render json: @review, except: :created_at
  end

  private
  def review_params
    params.require(:review).permit!
  end

  def find
    @review = Review.find(params[:review_id])
  end
end
