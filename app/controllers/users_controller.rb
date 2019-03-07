class UsersController < ApplicationController
  before_action :find_user, only: [:update, :show]
  skip_before_action :authenticate, only: [:new, :create, :login]

  def create
    @user = User.new(user_params)
    if @user.save
      give_token
    else
      render status: 422, json: {
        message: @user.errors.full_messages
      }.to_json
    end
  end

  # show one user
  def show
    render json: @user
  end

  # update a user
  def update
    @user.update!(user_params)
    redirect_to @user
  end

  # deletes a user
  def destroy
    User.destroy(user_params[:id])
  end

  def login
    @user = User.find_by(email: user_params[:email])
    if @user.nil?
      return render json: {
        message: "Can't find user with email #{user_params[:email]}"
      }, status: 404
    end
    if @user.authenticate(user_params[:password])
      give_token
    else
      render json: {
        message: "Wrong email/password combination"
      }, status: 401
    end
  end

  private
  def user_params
    params.require(:user).permit([:name, :email, :password, :id])
  end

  def find_user
    @user = User.find(user_params[:id])
  end

  def give_token
    token = Auth.issue({user: @user.id})
    render json: {
      token: token
    }
  end
end
