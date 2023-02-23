class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :middle_name
      t.string :last_name

      # original database stored passwords with SHA-1 hash algorithm, the port to rails will store passwords hashed with bcrypt
      t.string :old_password_sha1
      t.string :old_password_confirmation
      t.boolean :password_converted, default: false
      t.string :password
      t.string :password_confirmation

      t.string :password_reset_key
      t.datetime :password_reset_key_timestamp
      t.string :account_activation_key
      t.boolean :account_activated
      t.boolean :agreed_to_eula

      t.boolean :author_user, default: false
      t.boolean :reviewer_user, default: false
      t.boolean :editor_user, default: false
      t.boolean :publisher_user, default: false
      t.boolean :admin_user, default: false


      t.timestamps
    end
  end
end
