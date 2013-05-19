class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :student_id
      t.integer :mentor_id
      t.string :payment_id
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end