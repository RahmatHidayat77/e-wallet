class BankHistory < ApplicationRecord
    self.inheritance_column = nil

    belongs_to :balance_bank

    enum type: {credit: 'credit', debit: 'debit'}
end
