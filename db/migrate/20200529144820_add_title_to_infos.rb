class AddTitleToInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :infos, :title, :string
  end
end
