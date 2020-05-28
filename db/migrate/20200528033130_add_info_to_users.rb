class AddInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :info, :string
  end
end
