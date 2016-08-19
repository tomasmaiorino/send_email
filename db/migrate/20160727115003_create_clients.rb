class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :token
      t.boolean :active, :default => false
      t.timestamps null: false
    end
  end
end
