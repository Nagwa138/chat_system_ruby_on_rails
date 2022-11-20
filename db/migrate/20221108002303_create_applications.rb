class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :name, unique: true
      t.string :token
      t.integer :chat_count, default: 0

      t.timestamps
    end
  end
end
