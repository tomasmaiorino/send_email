class CreateClientSenders < ActiveRecord::Migration
  def change
    create_table :client_senders do |t|
	  t.t.references :client, index: true
	  t.t.references :sender, index: true
      t.timestamps null: false
    end
  end
end
