class UsersController < ApplicationController
  wrap_parameters format: []

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id 
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def show
    # user = User.find_by(user_id: params[:id])
    # if session[:user_id]
    #   render json: user 
    # else
    #   render json: { errors: "user not found" }, status: :unauthorized
    #   # render json: { errors: "user not found" }, status: :unprocessable_entity
    # end
    return render json:{error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
        user = User.find_by(id: session[:user_id])
        render json: user, status: :ok
  end

  private
  
  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
