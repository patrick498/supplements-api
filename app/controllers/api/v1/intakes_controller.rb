class Api::V1::IntakesController < ApplicationController
  def index
    render json: @current_user.intakes
  end
end
