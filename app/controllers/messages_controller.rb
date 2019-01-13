require 'date'
class MessagesController < ApplicationController
  # def create
  #   puts "THIS WAS CALLED"
  #   @message = Message.new#(contents: params.require(:session)[:contents])#, chatroom: params.require(:chatroom))
  #   users_controller = UsersController.new
  #   @message.user = current_user#session[:user]
  #   @message.date_sent = DateTime.now
  #   chatroom = Chatroom.find_by(id: session[:current_room]["id"])
  #   chatroom.messages << @message
  #   #@message.id = Messages.count - 1 # ex: after creating first message, count = 1, so id = 0
  #   unless @message.save!
  #     flash.now[:error] = "Could not create message"
  #   end
  # end
end
