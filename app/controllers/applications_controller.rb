class ApplicationsController < ApplicationController
  def index
    @apps = Application.select(:name, :token, :chat_count).all
    render json: { message: "list success!", applications: @apps }, status: :ok
  end

  def create
    @app = Application.new(app_params)
    if @app.save
      render json: { message: "Created successfully!", application: { name: @app.name, token: @app.token, chat_count: @app.chat_count } }
    else
      render json: { message: "Validation failed", errors: @app.errors }, status: :unprocessable_entity
    end
  end

  def show
    begin
      @app = Application.select(:name, :token, :chat_count).find_by(token: params[:id])
      render json: { message: "Show successfully!", application: @app}
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Application not found!"}, status: :not_found
    end
  end

  def update
    begin
      if Application.where("token != :token AND name = :name", token: params[:id] ,name: params[:name]).empty?

        @app = Application.find_by(token: params[:id])
        @app.update(name: params[:name])
        render json: { message: "Updated successfully!", application: { name: @app.name, token: @app.token, chat_count: @app.chat_count }}

      else
        render json: { message: "Validation failed", errors: {name: "has already been taken"} }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Application not found!"}, status: :not_found
    end
  end

  private
  def app_params
    params.require(:application).permit(:name)
  end
end
