class ChatsController < ApplicationController
  def index
    if Application.exists?(token: params[:application_id])
      @app = Application.find_by(token: params[:application_id])
      @chats = Chat.where(application_id: @app.id).select(:number, :message_count).all
      render json: { message: "list success!", chats: @chats }, status: :ok
    else
      render json: { message: "This application does not exist!" }, status: :not_found
    end
  end

  def create
    if Application.exists?(token: params['application_id'])
      @app = Application.find_by(token: params['application_id'])
      @chat = Chat.new(application_id: @app.id)
      if @chat.save
        @app.chat_count +=1
        @app.save
        render json: { message: "Created successfully!", chat: {number: @chat.number, message_count: @chat.message_count}}
      else
        render json: { message: "Validation failed", errors: @chat.errors }, status: :unprocessable_entity
      end
    else
      render json: { message: "Validation failed", errors: {application_token: "There is not application with this token!"} }, status: :unprocessable_entity
    end
  end

  def show
    if Application.exists?(token: params['application_id'])
      @app = Application.find_by(token: params['application_id'])
      # begin
        @chat = Chat.select(:number, :message_count).where(number: params[:id], application_id: @app.id).first
        if @chat
          render json: { message: "Show successfully!", chat: @chat}
        else
          render json: { message: "Chat not found!"}, status: :not_found
        end
      # rescue ActiveRecord::RecordNotFound
      #   render json: { message: "Chat not found!"}, status: :not_found
      # end
    else
      render json: { message: "Validation failed", errors: {application_token: "There is not application with this token!"} }, status: :unprocessable_entity
    end
  end

  # def update
  #   if Application.exists?(token: params['application_id'])
  #     @app = Application.find_by(token: params['application_id'])
  #     @chat = Chat.where(number: params[:id], application_id: @app.id).first
  #     if @chat
  #       if Chat.where("number = :number", number: params[:number]).empty?
  #
  #         @chat.update(number: params[:name])
  #         render json: { message: "Updated successfully!", application: { name: @app.name, token: @app.token, chat_count: @app.chat_count }}
  #
  #       else
  #         render json: { message: "Validation failed", errors: {name: "has already been taken"} }, status: :unprocessable_entity
  #       end
  #       render json: { message: "Show successfully!", chat: @chat}
  #     else
  #       render json: { message: "Chat not found!"}, status: :not_found
  #     end
  #   else
  #     render json: { message: "Validation failed", errors: {application_token: "There is not application with this token!"} }, status: :unprocessable_entity
  #   end
  # end
end
