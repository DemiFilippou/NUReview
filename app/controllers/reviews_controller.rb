class ReviewsController < ApplicationController
  before_action :find, only: [:update, :show]
  def index
    @reviews = Review.where(company_id: params[:company_id])
    render json: @reviews, except: [:updated_at, :created_at]
  end

  # update a user's review
  def update
    if @review.user == current_user
      if @review.update(review_params)
        render json: @review, except: :created_at
      else
        render json: {:errors => @review.errors.full_messages}
      end
      render json: { :errors => "You are not authorized to do this." }
    end
  end
  
  private
  def review_params
    params.require(:review).permit!
  end

  def find
    @review = Review.find(params[:id])
  end
end
