class Api::V1::MotorcycleController < ApplicationController
  def index
    @user = User.first
    @motorcycle = @user.motorcycles.all
    return render json: @motorcycle if @motorcycle

    render json: { message: 'Resource not found' }, status: :not_found
  end

  def show
    @user = User.first
    @motorcycle = @user.motorcycles.find_by(id: params[:id])
    return render json: @motorcycle, status: :ok if @motorcycle

    return unless @motorcycle.nil?

    render json: { message: 'Resource not found' }, status: :not_found
  end

  def create
    data = params
    Motorcycle.create!(name: data['name'], model: data['model'], description: data['description'],
                       photo: data['photo'], user: User.first)
    render json: { message: 'Created' }, status: :created
  rescue StandardError
    render json: { message: 'The request parameters are invalid. Please check your input and try again.' },
           status: :unprocessable_entity
  end
end
