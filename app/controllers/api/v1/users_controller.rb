class Api::V1::UsersController < ApplicationController

  # before_action :authenticate_user!

  def index
    users = User.all
    render json: {
        status: "success",
        message: "Users found",
        data: { users: users}
    }, status: :ok and return
  end

  def show
    user = User.find(params[:id])
    render json: {
                  status: "success",
                  message: "User found",
                  data: { users: user}
                 }, status: :ok and return
  end
end