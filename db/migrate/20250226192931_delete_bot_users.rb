class DeleteBotUsers < ActiveRecord::Migration[6.1]
  def change
    User.where("first_name = last_name").delete_all
  end
end
