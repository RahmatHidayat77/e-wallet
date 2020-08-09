json.extract! bank_history, :id, :balance_bank_id, :balance_before, :balance_after, :activity, :ip, :location, :user_agent, :author, :created_at, :updated_at
json.url bank_history_url(bank_history, format: :json)
