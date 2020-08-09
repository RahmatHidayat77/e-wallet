class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, :id => false do |t|
      t.integer :id, null: false, auto_increment: true, primary_key: true
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
