class ReviewsController < ApplicationController
  before_action :find, only: [:update, :show]

  def create
    @review = Review.new(review_params.merge(
      {
       user: current_user,
       company_id: params[:company_id]
      }))
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
  
  def show
    render json: @review, except: :created_at
  end

  private
  def review_params
    params.require(:review).permit!
  end

  def find
    @review = Review.find(params[:id])
  end
end
