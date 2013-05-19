class AddVerificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verify_code, :string
    add_column :users, :description, :text
  end
end
