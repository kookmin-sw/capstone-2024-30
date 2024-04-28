class CreateChatMessage < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_messages do |t|
      t.bigint :chat_room_id, null: false, foreign_key: true
      t.string :user_id, null: false, foreign_key: {to_table: :users, primary_key: "user_id"}
      t.text :content, null: false
      t.datetime :timestamp, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    add_foreign_key :chat_messages, :chat_rooms, column: :chat_room_id, primary_key: "id"
    add_foreign_key :chat_messages, :users, column: :user_id, primary_key: "user_id"
    add_index :chat_messages, :chat_room_id
    add_index :chat_messages, :user_id
    add_index :chat_messages, [:chat_room_id, :timestamp]
  end
end