class CreateEMessages < ActiveRecord::Migration
  def change
    create_table :e_messages do |t|
	 t.string :message
     t.string :code
     t.string :subject
     t.string :sender_name
     t.string :sender_email
     t.string :token
     t.boolean :async, :default => false
     t.boolean :is_message_valid, :default => false
     t.timestamps null: false
    end
  end
end
