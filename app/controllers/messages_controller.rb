class MessagesController < ApplicationController
  def index
    if Application.exists?(token: params[:application_id])
      @app = Application.find_by(token: params[:application_id])
      @chat = Chat.where(number: params[:chat_id], application_id: @app.id).first
      if @chat
        @messages = Message.where('body LIKE :search', search: "%#{params[:search]}%", chat_id: @chat.id).select(:number, :body).all
        render json: { message: "list success!", messages: @messages }, status: :ok
      else
        render json: { message: "Chat not found!"}, status: :not_found
      end
    else
      render json: { message: "Validation failed", errors: {application_token: "There is not application with this token!"} }, status: :unprocessable_entity
    end
  end

  def create
    if Application.exists?(token: params[:application_id])
      @app = Application.find_by(token: params[:application_id])
      @chat = Chat.where(number: params[:chat_id], application_id: @app.id).first
      if @chat
        #todo :: add try & catch in saving the message
        @message = Message.new(chat_id: @chat.id, body: params[:body])
        if @message.save
          @chat.message_count +=1
          @chat.save
          render json: { message: "Create success!", message_added: {number: @message.number, body: @message.body} }, status: :ok
        else
          render json: { message: "Validation failed", errors: @message.errors }, status: :unprocessable_entity
        end
      else
        render json: { message: "Chat not found!"}, status: :not_found
      end
    else
      render json: { message: "Validation failed", errors: {application_token: "There is not application with this token!"} }, status: :unprocessable_entity
    end
  end

end
