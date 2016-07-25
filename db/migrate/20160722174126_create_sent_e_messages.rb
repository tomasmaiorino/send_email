class CreateSentEMessages < ActiveRecord::Migration
  def change
    create_table :sent_e_messages do |t|
	  t.string :name
      t.boolean :active, :default => false
      t.string :sender_class
      t.belongs_to :emessage, index: true
      t.timestamps null: false
    end
  end
end
