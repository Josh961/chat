class ChatroomsController < ApplicationController

  # creates a chat_room
  def create
    @chatroom = Chatroom.new(chatroom_params)
    @chatroom.chat_room_name = params[:chatroom][:chat_room_name]
    @chatroom.date_created = DateTime.now
    @chatroom.number_of_stars = 0
    session[:current_room] = @chatroom
    if @chatroom.save
      redirect_to home_url
    end
  end

  # returns all chatrooms
  def index
    # For making a new chatroom in the modal
    @chatroom = Chatroom.new
    # Display all rooms
    @rooms = Chatroom.all
  end

  # returns all starred chatrooms
  def starred
    @chatroom = Chatroom.new
    @rooms = current_user.get_starred_chatrooms
  end

  # returns all messages in specific chatroom
  def show
    @messages = Message.order(created_at: :asc)
    @current_uri = request.path
    chatroom = @current_uri.delete "/chatrooms/"
    @chatroom = Chatroom.find_by(id: chatroom)
    # @room_messages = @chatroom.messages.all
    session[:current_room] = @chatroom
  end

  private
  def chatroom_params
    params.require(:chatroom).permit(:chat_room_name)
  end
end
