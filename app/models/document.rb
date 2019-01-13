class Document < ApplicationRecord
  belongs_to :chatroom # chat_room
  has_one :user # uploaded_by
end
