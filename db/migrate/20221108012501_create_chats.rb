class CreateChats < ActiveRecord::Migration[7.0]
  def up
    create_table :chats do |t|
      t.integer :number, null: false
      t.references :application, null: false, foreign_key: { on_delete: :cascade}
      t.integer :message_count, default: 0

      t.timestamps
    end
  end

  def down
    drop_table :chats
  end
end
