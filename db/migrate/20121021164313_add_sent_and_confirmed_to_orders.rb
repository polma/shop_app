class AddSentAndConfirmedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :confirmed, :boolean
    add_column :orders, :sent, :boolean
  end
end
