class CreateEMessages < ActiveRecord::Migration
  def change
    create_table :e_messages do |t|

      t.timestamps null: false
    end
  end
end
