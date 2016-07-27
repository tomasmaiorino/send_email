class CreateSentEMessages < ActiveRecord::Migration
  def change
    create_table :sent_e_messages do |t|
	  t.string :status
      t.timestamps :date_sent
      t.belongs_to :emessage, index: true
      t.belongs_to :sender, index: true
      t.timestamps null: false
      t.string :message
    end
  end
end
