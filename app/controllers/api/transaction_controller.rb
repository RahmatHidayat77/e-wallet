class Api::TransactionController < ApplicationController
    def topup
        balance_history_params = {}

        if topup_params[:email].present?
            code = ('a'..'z').to_a.shuffle[0,8].join

            user = User.where(email: topup_params[:email]).first
            if user.nil?
                raise(ActiveRecord::RecordNotFound, Message.not_found)
            end
            user_balance = UserBalance.where(user_id: user.id).last
            if user_balance.nil?
                user_balance = UserBalance.create(user_id: user.id, balance: topup_params[:nominal], balance_achieve: topup_params[:nominal])
                
                balance_history_params = {
                    user_balance_id: user_balance.id,
                    balance_before: 0,
                    balance_after: topup_params[:nominal],
                    activity: topup_params[:activity],
                    type: UserBalanceHistory.types.keys.first,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: topup_params[:user_agent],
                    author: user.email
                }

                user_balance_history = UserBalanceHistory.new(balance_history_params)
                user_balance_history.save!

                new_balance_bank = BalanceBank.create(balance: topup_params[:nominal], balance_achieve: topup_params[:nominal], code: code, enable: true)

                balance_bank_history_params = {
                    balance_bank_id: new_balance_bank.id,
                    balance_before: 0,
                    balance_after: new_balance_bank.balance,
                    activity: topup_params[:activity],
                    type: BankHistory.types.keys.first,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: topup_params[:user_agent],
                    author: user.email
                }
                balance_bank_history = BankHistory.new(balance_history_params)
                balance_bank_history.save!

            else
                value = user_balance.balance + topup_params[:nominal].to_i

                new_user_balance_params = {
                    user_id: user.id,
                    balance: value,
                    balance_achieve: transfer_params[:nominal].to_i
                }

                new_user_balance = UserBalance.new(new_user_balance_params)
                new_user_balance.save!
                
                balance_history_params = {
                    user_balance_id: new_user_balance.id,
                    balance_before: user_balance.balance,
                    balance_after: value,
                    activity: topup_params[:activity],
                    type: UserBalanceHistory.types.keys.first,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: topup_params[:user_agent],
                    author: user.email
                }
                user_balance_history = UserBalanceHistory.new(balance_history_params)
                user_balance_history.save!

                current_balance_bank = BalanceBank.last

                if current_balance_bank.nil?
                    raise(ActiveRecord::RecordNotFound, Message.not_found)
                end

                new_balance_bank = BalanceBank.create(balance: value, balance_achieve: topup_params[:nominal], code: code, enable: true)

                balance_bank_history_params = {
                    balance_bank_id: new_balance_bank.id,
                    balance_before: current_balance_bank.balance,
                    balance_after: new_balance_bank.balance,
                    activity: topup_params[:activity],
                    type: BankHistory.types.keys.first,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: topup_params[:user_agent],
                    author: user.email
                }
                balance_bank_history = BankHistory.new(balance_bank_history_params)
                balance_bank_history.save!
            end

            response = { message: Message.top_up_success, balance: new_user_balance.balance }
            json_response(response, :ok)
        else
            raise(ExceptionHandler::ParamsRequired, Message.params_cannot_null)
        end
    end

    def transfer
        if transfer_params[:sender].present? && transfer_params[:receiver].present?
            # taking action to sender
            sender = User.where(email: transfer_params[:sender]).first
            if sender.nil?
                raise(ActiveRecord::RecordNotFound, Message.not_found)
            end
            sender_balance = UserBalance.where(user_id: sender.id).last
            if sender_balance.nil? || sender_balance.balance <= 0
                raise(ExceptionHandler::RecordInvalid, Message.not_have_balance)
            else
                value = sender_balance.balance - transfer_params[:nominal].to_i
                
                sender_balance_params = {
                    user_id: sender.id,
                    balance: value,
                    balance_achieve: -transfer_params[:nominal].to_i
                }

                new_sender_balance = UserBalance.new(sender_balance_params)
                new_sender_balance.save!

                balance_sender_history_params = {
                    user_balance_id: new_sender_balance.id,
                    balance_before: sender_balance.balance,
                    balance_after: value,
                    activity: transfer_params[:activity],
                    type: UserBalanceHistory.types.keys.second,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: transfer_params[:user_agent],
                    author: sender.email
                }
                user_balance_history = UserBalanceHistory.new(balance_sender_history_params)
                user_balance_history.save!
            end


            # taking action to receiver
            receiver = User.where(email: transfer_params[:receiver]).first
            if receiver.nil?
                raise(ActiveRecord::RecordNotFound, Message.not_found)
            end
            receiver_balance = UserBalance.where(user_id: receiver.id).last
            if receiver_balance.nil?
                receiver_balance = UserBalance.create(user_id: receiver.id, balance: transfer_params[:nominal], balance_achieve: transfer_params[:nominal])
                
                balance_receiver_history_params = {
                    user_balance_id: receiver_balance.id,
                    balance_before: 0,
                    balance_after: transfer_params[:nominal],
                    activity: transfer_params[:activity],
                    type: UserBalanceHistory.types.keys.first,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: transfer_params[:user_agent],
                    author: receiver.email
                }

                user_balance_history = UserBalanceHistory.new(balance_receiver_history_params)
                user_balance_history.save!
            else
                value = receiver_balance.balance + transfer_params[:nominal].to_i

                new_receiver_balance = UserBalance.create(user_id: receiver.id, balance: transfer_params[:nominal], balance_achieve: transfer_params[:nominal])

                balance_receiver_history_params = {
                    user_balance_id: new_receiver_balance.id,
                    balance_before: new_receiver_balance.balance,
                    balance_after: value,
                    activity: transfer_params[:activity],
                    type: UserBalanceHistory.types.keys.first,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: transfer_params[:user_agent],
                    author: receiver.email
                }
                user_balance_history = UserBalanceHistory.new(balance_receiver_history_params)
                user_balance_history.save!

                receiver_balance.update(balance: value, balance_achieve: transfer_params[:nominal])
            end

            response = { message: Message.transfer_success(receiver.email), nominal: transfer_params[:nominal].to_i, balance: new_sender_balance.balance }
            json_response(response, :ok)
        else
            raise(ExceptionHandler::ParamsRequired, Message.params_cannot_null)
        end        
    end

    def purchase
        if purchase_params[:email].present?
            code = ('a'..'z').to_a.shuffle[0,8].join

            user = User.where(email: purchase_params[:email]).first
            if user.nil?
                raise(ActiveRecord::RecordNotFound, Message.not_found)
            end
            purchase_balance = UserBalance.where(user_id: user.id).last
            if purchase_balance.nil? || purchase_balance.balance <= 0
                raise(ExceptionHandler::RecordInvalid, Message.not_have_balance)
            else
                value = purchase_balance.balance - purchase_params[:nominal].to_i
                
                purchase_balance_params = {
                    user_id: user.id,
                    balance: value,
                    balance_achieve: -purchase_params[:nominal].to_i
                }

                new_purchase_balance = UserBalance.new(purchase_balance_params)
                new_purchase_balance.save!

                balance_purchase_history_params = {
                    user_balance_id: new_purchase_balance.id,
                    balance_before: purchase_balance.balance,
                    balance_after: value,
                    activity: purchase_params[:activity],
                    type: UserBalanceHistory.types.keys.second,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: purchase_params[:user_agent],
                    author: user.email
                }
                user_balance_history = UserBalanceHistory.new(balance_purchase_history_params)
                user_balance_history.save!

                current_balance_bank = BalanceBank.last

                if current_balance_bank.nil?
                    raise(ActiveRecord::RecordNotFound, Message.not_found)
                end

                value = current_balance_bank.balance - purchase_params[:nominal].to_i

                new_balance_bank = BalanceBank.create(balance: value, balance_achieve: -purchase_params[:nominal].to_i, code: code, enable: true)

                balance_bank_history_params = {
                    balance_bank_id: new_balance_bank.id,
                    balance_before: current_balance_bank.balance,
                    balance_after: new_balance_bank.balance,
                    activity: purchase_params[:activity],
                    type: BankHistory.types.keys.first,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: purchase_params[:user_agent],
                    author: user.email
                }
                balance_bank_history = BankHistory.new(balance_bank_history_params)
                balance_bank_history.save!
            end
            response = { message: Message.purchase_success, balance: new_purchase_balance.balance }
            json_response(response, :ok)
        else
            raise(ExceptionHandler::ParamsRequired, Message.params_cannot_null)
        end
    end

    private

    def topup_params
        params.permit(:email, :nominal, :activity, :user_agent)   
    end

    def transfer_params
        params.permit(:sender, :receiver, :nominal, :activity, :user_agent)
    end

    def purchase_params
        params.permit(:email, :nominal, :activity, :user_agent)
    end
end
