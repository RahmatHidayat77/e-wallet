json.extract! user_balance, :id, :userId, :balance, :balanceAchive, :created_at, :updated_at
json.url user_balance_url(user_balance, format: :json)
