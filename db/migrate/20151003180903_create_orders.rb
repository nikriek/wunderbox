class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :category
      t.string :folder
      t.integer :pricing
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
