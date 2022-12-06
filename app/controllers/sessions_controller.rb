class SessionsController < ApplicationController
  wrap_parameters format: []

  def create
    user = User.find_by(username: params[:username])
    # user = User.authenticate(params[:username])
    # if user 
    if user&.authenticate(params[:password])
      session[:user_id] = user.id 
      render json: user, status: :created 
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  def destroy
    # user = User.find_by(username, params[:username])
    # user.destroy
    session[:user_id] = nil
  end

end
