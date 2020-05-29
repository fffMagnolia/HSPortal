class CreateInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :infos do |t|
      t.text :message
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
    add_index :infos, [:event_id, :created_at]
  end
end
