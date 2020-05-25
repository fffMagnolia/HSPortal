class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
    add_index :entries, :user_id
    add_index :entries, :event_id
    add_index :entries, [:user_id, :event_id], unique: true
  end
end
