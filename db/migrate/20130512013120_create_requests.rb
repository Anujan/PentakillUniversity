class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :student_id
      t.integer :mentor_id
      t.string :goal_tier
      t.string :goal_division
      t.decimal :price, :precision => 8, :scale => 2
      
      t.timestamps
    end
  end
end
