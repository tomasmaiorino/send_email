class CreateSentEMessages < ActiveRecord::Migration
  def change
    create_table :sent_e_messages do |t|
	  t.string :status
      t.references :e_message, index: true
      t.references :sender, index: true
      t.timestamps null: false
      t.string :message
    end
  end
end
