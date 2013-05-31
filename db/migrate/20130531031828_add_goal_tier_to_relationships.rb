class AddGoalTierToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :goal_tier, :string
    add_column :relationships, :goal_division, :string
  end
end
