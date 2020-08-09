class Api::UserBalancesController < ApplicationController
  before_action :set_user_balance, only: [:show, :edit, :update, :destroy]

  # GET /user_balances
  # GET /user_balances.json
  def index
    @user_balances = UserBalance.all
  end

  # GET /user_balances/1
  # GET /user_balances/1.json
  def show
  end

  # GET /user_balances/new
  def new
    @user_balance = UserBalance.new
  end

  # GET /user_balances/1/edit
  def edit
  end

  # POST /user_balances
  # POST /user_balances.json
  def create
    @user_balance = UserBalance.new(user_balance_params)

    respond_to do |format|
      if @user_balance.save
        format.html { redirect_to @user_balance, notice: 'User balance was successfully created.' }
        format.json { render :show, status: :created, location: @user_balance }
      else
        format.html { render :new }
        format.json { render json: @user_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_balances/1
  # PATCH/PUT /user_balances/1.json
  def update
    respond_to do |format|
      if @user_balance.update(user_balance_params)
        format.html { redirect_to @user_balance, notice: 'User balance was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_balance }
      else
        format.html { render :edit }
        format.json { render json: @user_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_balances/1
  # DELETE /user_balances/1.json
  def destroy
    @user_balance.destroy
    respond_to do |format|
      format.html { redirect_to user_balances_url, notice: 'User balance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_balance
      @user_balance = UserBalance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_balance_params
      params.require(:user_balance).permit(:userId, :balance, :balanceAchive)
    end
end
