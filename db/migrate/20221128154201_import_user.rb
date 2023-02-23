class ImportUser < ActiveRecord::Migration[6.1]

  require 'json'

  FILE = "#{Rails.root}/tmp/users.json"

  def up

    User.all.delete_all

    file = File.read(FILE)
    data = JSON.parse(file)
    data.each_with_index do |a, i|
      User.create(id:a['user_id'], email: a['email'], first_name: a['first_name'], middle_name: a['middle_name'], last_name: a['last_name'],
      old_password_sha1: a['password'], agreed_to_eula: a['agreed_to_eula'] == "1" ? true : false
      )
      puts "User #{i + 1} of #{data.size}"
    end
  end

  def down
    User.all.delete_all
  end
end
