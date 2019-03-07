class ReviewsController < ApplicationController
  before_action :find, only: [:update, :show]

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
      render json: {:errors => @review.errors.full_messages}, status: 422
    end
  end

  # update a user's review
  def update
    if @review.user == current_user
      if @review.update(review_params)
        show
      else
        render json: {:errors => @review.errors.full_messages}, status: 422
      end
      render json: { :errors => "You are not authorized to do this." }, status: 401
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
