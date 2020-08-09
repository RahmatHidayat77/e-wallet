class Api::TransactionController < ApplicationController
    def topup
        balance_history_params = {}

        if topup_params[:email].present?

            user = User.where(email: topup_params[:email]).first
            user_balance = UserBalance.where(user_id: user.id).first
            if user_balance.nil?
                new_user_balance = UserBalance.create(user_id: user.id, balance: topup_params[:nominal], balance_achieve: topup_params[:nominal])
                
                balance_history_params = {
                    user_balance_id: new_user_balance.id,
                    balance_before: 0,
                    balance_after: topup_params[:nominal],
                    activity: topup_params[:activity],
                    type: 'credit',
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
                    type: UserBalanceHistory.credit,
                    ip: remote_ip(),
                    location: location(),
                    user_agent: topup_params[:user_agent],
                    author: user.email
                }
                user_balance_history = UserBalanceHistory.new(balance_history_params)
                user_balance_history.save!

                user_balance.update(balance: value, balance_achieve: topup_params[:nominal])
            end
        else
            raise(ExceptionHandler::AuthenticationError, Message.params_cannot_null)
        end
    end

    private

    def topup_params
        params.permit(:email, :nominal, :activity, :type, :user_agent)   
    end
end
