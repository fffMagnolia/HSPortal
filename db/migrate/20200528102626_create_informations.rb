class CreateInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :informations do |t|
      t.string :message
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
    add_index :informations, [:event_id, :created_at]
  end
end
