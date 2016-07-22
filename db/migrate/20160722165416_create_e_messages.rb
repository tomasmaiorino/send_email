class CreateEMessages < ActiveRecord::Migration
  def change
    create_table :e_messages do |t|

	 t.string :message
     t.string :subject
     t.string :sender_name
     t.string :sender_email
     t.string :token
     t.booelan :async, :default => false
     t.boolean :valid, :default => false
     t.timestamps null: false
    end
  end
end
