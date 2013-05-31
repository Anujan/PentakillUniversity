class RemoveCreateFromPaymentNotifications < ActiveRecord::Migration
  def up
    remove_column :payment_notifications, :create
  end

  def down
    add_column :payment_notifications, :create, :string
  end
end
