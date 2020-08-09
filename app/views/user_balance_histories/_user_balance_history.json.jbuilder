json.extract! user_balance_history, :id, :user_balance_id, :balance_before, :balance_after, :activity, :created_at, :updated_at
json.url user_balance_history_url(user_balance_history, format: :json)
