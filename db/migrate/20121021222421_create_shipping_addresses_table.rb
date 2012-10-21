class CreateShippingAddressesTable < ActiveRecord::Migration
  def up
    create_table :shipping_addresses do |t|
      t.integer :order_id
      
      t.string :name
      t.string :surname
      t.string :street
      t.string :city
      t.string :house_nr
      t.string :flat_nr
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end

  def down
    drop_table :shipping_addresses
  end
end
