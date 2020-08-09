class CreateBalanceBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :balance_banks, :id => false do |t|
      t.integer :id, null: false, auto_increment: true, primary_key: true
      t.integer :balance, null: false
      t.integer :balance_achieve, null: false
      t.string :code
      t.boolean :enable, null: false

      t.timestamps
    end
  end
end
