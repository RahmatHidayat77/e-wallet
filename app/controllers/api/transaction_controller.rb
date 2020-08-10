class Api::TransactionController < ApplicationController
    def topup
        balance_history_params = {}

        if topup_params[:email].present?

            user = User.where(email: topup_params[:email]).first
            if user.nil?
                raise(ActiveRecord::RecordNotFound, Message.not_found)
            end
            user_balance = UserBalance.where(user_id: user.id).first
            if user_balance.nil?
                new_user_balance = UserBalance.create(user_id: user.id, balance: topup_params[:nominal], balance_achieve: topup_params[:nominal])
                
                balance_history_params = {
                    user_balance_id: new_user_balance.id,
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
            else
                value = user_balance.balance + topup_params[:nominal].to_i
                
                balance_history_params = {
                    user_balance_id: user_balance.id,
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

                user_balance.update(balance: value, balance_achieve: topup_params[:nominal])
            end

            response = { message: Message.top_up_success, balance: user_balance.balance }
            json_response(response, :ok)
        else
            raise(ExceptionHandler::ParamsRequired, Message.params_cannot_null)
        end
    end

    def transfer
        balance_history_params = {}

        if transfer_params[:sender].present? && transfer_params[:receiver].present?
            # taking action to sender
            sender = User.where(email: transfer_params[:sender]).first
            if sender.nil?
                raise(ActiveRecord::RecordNotFound, Message.not_found)
            end
            sender_balance = UserBalance.where(user_id: sender.id).first
            if sender_balance.nil? || sender_balance.balance <= 0
                raise(ExceptionHandler::RecordInvalid, Message.not_have_balance)
            else
                value = sender_balance.balance - transfer_params[:nominal].to_i
                
                balance_sender_history_params = {
                    user_balance_id: sender_balance.id,
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

                sender_balance.update(balance: value, balance_achieve: transfer_params[:nominal])
            end


            # taking action to receiver
            receiver = User.where(email: transfer_params[:receiver]).first
            if receiver.nil?
                raise(ActiveRecord::RecordNotFound, Message.not_found)
            end
            receiver_balance = UserBalance.where(user_id: receiver.id).first
            if receiver_balance.nil?
                receiver_balance = UserBalance.create(user_id: receiver.id, balance: transfer_params[:nominal], balance_achieve: transfer_params[:nominal])
                
                balance_receiver_history_params = {
                    user_balance_id: receiver.id,
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
                
                balance_receiver_history_params = {
                    user_balance_id: receiver_balance.id,
                    balance_before: receiver_balance.balance,
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

            response = { message: Message.transfer_success(receiver.email), nominal: transfer_params[:nominal].to_i, balance: sender_balance.balance }
            json_response(response, :ok)
        else
            raise(ExceptionHandler::ParamsRequired, Message.params_cannot_null)
        end        
    end

    def purchase
    end

    private

    def topup_params
        params.permit(:email, :nominal, :activity, :user_agent)   
    end

    def transfer_params
        params.permit(:sender, :receiver, :nominal, :activity, :user_agent)
    end

    def purchase_params
        params.permit(:email, :nominal, :activity)
    end
end
