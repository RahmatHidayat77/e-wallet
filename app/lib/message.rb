class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token, login required!'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.params_cannot_null
    'Params cannot null'
  end
  def self.not_have_balance
    'Sorry, your balance is zero. Please topup first'
  end
  def self.top_up_success
    'Top Up successfully'
  end
  def self.purchase_success
    'Purchase successfully'
  end
  def self.transfer_success(receiver)
    "Transfer to #{receiver} successfully"
  end
end