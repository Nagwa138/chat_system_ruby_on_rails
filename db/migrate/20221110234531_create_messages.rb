class CreateMessages < ActiveRecord::Migration[7.0]
  def up
    create_table :messages do |t|
      t.string :body
      t.integer :number, null: false
      t.references :chat, null: false, foreign_key: { on_delete: :cascade}

      t.timestamps
    end
  end

  def down
    drop_table :messages
  end
end
