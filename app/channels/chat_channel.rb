class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
    # stream_from "room-#{params['room']}:messages"
  end

  def unsubscribed
  end

  def send_message(data)
    chatroom = Chatroom.find_by(chat_room_name: data['current_room'])
    message = Message.new(contents: data['message'], user: current_user, chatroom: chatroom, date_sent: DateTime.now)
    
    # Checks if a file is attached
    if data['file_uri']
      message.attachment_name = data['original_name']
      message.attachment_data_uri = data['file_uri']
    end
    chatroom.messages << message
    unless message.save!
      puts "COULD NOT SAVE"
      flash.now[:error] = "Could not create message"
    end
  end
end
