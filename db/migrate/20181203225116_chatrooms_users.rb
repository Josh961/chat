class ChatroomsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms_users, id: false do |t|
      t.timestamps null: false
      t.integer :user_id
      t.integer :chatroom_id
      t.belongs_to :chatroom, index: true
      t.belongs_to :user, index: true
    end
  end
end
