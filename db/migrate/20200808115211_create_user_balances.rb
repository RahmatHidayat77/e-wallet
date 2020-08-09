class CreateUserBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :user_balances, :id => false do |t|
      t.integer :id, null: false, auto_increment: true, primary_key: true
      t.integer :user_id, null: false
      t.integer :balance, null: false
      t.integer :balance_achieve, null: false

      t.timestamps
    end
  end
end
