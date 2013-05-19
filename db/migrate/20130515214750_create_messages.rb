class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :game_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
