class CreateBankHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_histories, :id => false do |t|
      t.integer :id, null: false, auto_increment: true, primary_key: true
      t.integer :balance_bank_id, null: false
      t.integer :balance_before, null: false
      t.integer :balance_after, null: false
      t.string :activity
      t.column :type, "ENUM('credit', 'debit')", null: false
      t.string :ip
      t.string :location
      t.string :user_agent
      t.string :author

      t.timestamps
    end
  end
end
