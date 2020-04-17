class AddPasswordDigestToUses < ActiveRecord::Migration[6.0]
  def change
    add_column :uses, :password_digest, :string
  end
end
