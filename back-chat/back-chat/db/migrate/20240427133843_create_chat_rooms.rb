class CreateChatRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_rooms do |t|
      t.string :user1_uuid, null:false
      t.string :user2_uuid, null:false

      t.timestamps
    end
    add_index :chat_rooms, [:user1_uuid, :user2_uuid], unique: true
  end
end
