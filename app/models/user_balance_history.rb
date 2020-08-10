class UserBalanceHistory < ApplicationRecord
    self.inheritance_column = nil
    belongs_to :user_balance


    enum type: {credit: 'credit', debit: 'debit'}
end
