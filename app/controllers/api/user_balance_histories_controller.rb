class Api::UserBalanceHistoriesController < ApplicationController
  before_action :set_user_balance_history, only: [:show, :edit, :update, :destroy]

  # GET /user_balance_histories
  # GET /user_balance_histories.json
  def index
    @user_balance_histories = UserBalanceHistory.all
  end

  # GET /user_balance_histories/1
  # GET /user_balance_histories/1.json
  def show
  end

  # GET /user_balance_histories/new
  def new
    @user_balance_history = UserBalanceHistory.new
  end

  # GET /user_balance_histories/1/edit
  def edit
  end

  # POST /user_balance_histories
  # POST /user_balance_histories.json
  def create
    @user_balance_history = UserBalanceHistory.new(user_balance_history_params)

    respond_to do |format|
      if @user_balance_history.save
        format.html { redirect_to @user_balance_history, notice: 'User balance history was successfully created.' }
        format.json { render :show, status: :created, location: @user_balance_history }
      else
        format.html { render :new }
        format.json { render json: @user_balance_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_balance_histories/1
  # PATCH/PUT /user_balance_histories/1.json
  def update
    respond_to do |format|
      if @user_balance_history.update(user_balance_history_params)
        format.html { redirect_to @user_balance_history, notice: 'User balance history was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_balance_history }
      else
        format.html { render :edit }
        format.json { render json: @user_balance_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_balance_histories/1
  # DELETE /user_balance_histories/1.json
  def destroy
    @user_balance_history.destroy
    respond_to do |format|
      format.html { redirect_to user_balance_histories_url, notice: 'User balance history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_balance_history
      @user_balance_history = UserBalanceHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_balance_history_params
      params.require(:user_balance_history).permit(:user_balance_id, :balance_before, :balance_after, :activity)
    end
end
