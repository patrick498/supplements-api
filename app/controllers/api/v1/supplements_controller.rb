class Api::V1::SupplementsController < ApplicationController
  def index
    render json: @current_user.supplements
  end
end
