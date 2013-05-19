class AddSummonerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :summonerid, :integer
    add_column :users, :acctid, :integer
    add_column :users, :ign, :string
    add_column :users, :server, :string
    add_column :users, :roles, :string
    add_column :users, :tier, :string
    add_column :users, :type, :string
  end
end
