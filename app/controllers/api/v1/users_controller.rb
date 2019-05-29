class Api::V1::UsersController < ApplicationController
  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: user
    else
      render json: {errors: "username or password is incorrect"}
    end

    # does this work??
    # render json: user && user.authenticate(params[:password])
  end
end
