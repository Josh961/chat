require 'test_helper'

class ChatroomsControllerTest < ActionDispatch::IntegrationTest
   test "the truth" do
     assert true
   end

   test "chatroom creation successful" do 
     @chatroom = Chatroom.create 
     assert_not_nil(@chatroom.updated_at)
   end 
end
