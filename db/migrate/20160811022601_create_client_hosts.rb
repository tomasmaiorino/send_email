class CreateClientHosts < ActiveRecord::Migration
  def change
    create_table :client_hosts do |t|
	  t.references :client, index: true
	  t.string :host
      t.timestamps null: false
    end
  end
end
