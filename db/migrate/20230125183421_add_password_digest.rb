class AddPasswordDigest < ActiveRecord::Migration[6.1]

  def change
    rename_column :users, :password, :password_hash
    add_column :users, :password_salt, :string
  end

end
