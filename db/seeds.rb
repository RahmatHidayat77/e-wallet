# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# password : 1234567
User.create(username: 'rh77', email: 'rh77@mail.com', password_digest: '$2a$12$F9G9WXa2zWWS39unZMgXe.UPG4ZF.Trw7WCw/P.T8hyxN2p2vPsnW')
# password : 12345678
User.create(username: 'rh88', email: 'rh88@mail.com', password_digest: '$2a$12$xTZijN2Iw79mENNnYBitjOroiZqfQZch81PxzHZkTAnp2hpk9JuWe')


UserBalance.create(user_id: 1, balance: 10000, balance_achieve: 10000)
UserBalance.create(user_id: 1, balance: 30000, balance_achieve: 20000)
UserBalance.create(user_id: 1, balance: 25000, balance_achieve: -5000)
UserBalance.create(user_id: 2, balance: 13000, balance_achieve: 8000)
UserBalance.create(user_id: 1, balance: 17000, balance_achieve: -8000)
UserBalance.create(user_id: 1, balance: 8000, balance_achieve: 8000)


UserBalanceHistory.create(user_balance_id: 1, balance_before: 0, balance_after: 10000, activity: 'topup', type: 'credit', ip: '127.0.0.1', location: 'Home', user_agent: 'agent1', author: 'rh77@mail.com')
UserBalanceHistory.create(user_balance_id: 2, balance_before: 10000, balance_after: 30000, activity: 'topup', type: 'credit', ip: '127.0.0.1', location: 'Home',  user_agent: 'agent1', author: 'rh77@mail.com')
UserBalanceHistory.create(user_balance_id: 3, balance_before: 30000, balance_after: 25000, activity: 'bayar hutang', type: 'debit', ip: '127.0.0.1', location: 'Home', user_agent: 'agent2', author: 'rh77@mail.com')
UserBalanceHistory.create(user_balance_id: 4, balance_before: 0, balance_after: 5000, activity: 'bayar hutang', type: 'credit', ip: '127.0.0.1', location: 'Home', user_agent: 'agent2', author: 'rh88@mail.com')
UserBalanceHistory.create(user_balance_id: 5, balance_before: 25000, balance_after: 17000, activity: 'bayar hutang', type: 'debit', ip: '127.0.0.1', location: 'Home', user_agent: 'agent2', author: 'rh77@mail.com')
UserBalanceHistory.create(user_balance_id: 1, balance_before: 8000, balance_after: 13000, activity: 'bayar hutang', type: 'credit', ip: '127.0.0.1', location: 'Home', user_agent: 'agent2', author: 'rh88@mail.com')


BalanceBank.create(balance: 10000, balance_achieve: 10000, code: 'ngmcrdft', enable: 1)
BalanceBank.create(balance: 30000, balance_achieve: 20000, code: 'fvskpgxa', enable: 1)


BankHistory.create(balance_bank_id: 1, balance_before: 0, balance_after: 10000, activity: 'topup', type: 'credit', ip: '127.0.0.1', location: 'Home', user_agent: 'agent1', author: 'rh77@mail.com')
BankHistory.create(balance_bank_id: 1, balance_before: 10000, balance_after: 30000, activity: 'topup', type: 'credit', ip: '127.0.0.1', location: 'Home', user_agent: 'agent1', author: 'rh77@mail.com')