class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :student_id
      t.integer :mentor_id
      t.string :message

      t.timestamps
    end
  end
end
