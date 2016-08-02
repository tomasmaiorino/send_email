class CreateSenders < ActiveRecord::Migration
  def change
    create_table :senders do |t|
 	  t.string :name
      t.boolean :active, :default => false
      t.string :sender_class
      t.string :additional_data
      t.string :sender_from
      t.timestamps null: false
    end
  end
end
