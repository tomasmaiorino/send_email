class CreateSentEMessages < ActiveRecord::Migration
  def change
    create_table :sent_e_messages do |t|

      t.timestamps null: false
    end
  end
end
