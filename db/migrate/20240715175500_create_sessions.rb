class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :token
  
      t.timestamps null: false
    end
  
    add_index :sessions, :token, unique: true
  end
end
