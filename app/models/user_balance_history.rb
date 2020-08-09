class UserBalanceHistory < ApplicationRecord
    belongs_to :user_balance

    enum type: [:credit, :debet]
end
