class CreateClientSenders < ActiveRecord::Migration
  def change
    create_table :client_senders do |t|
	  t.belongs_to :client, index: true
	  t.belongs_to :sender, index: true
      t.timestamps null: false
    end
  end
end
