class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.string :chat_room_name
      t.datetime :date_created
      t.integer :number_of_stars

      t.timestamps
    end
  end
end
