class Api::BalanceBanksController < ApplicationController
  before_action :set_balance_bank, only: [:show, :edit, :update, :destroy]

  # GET /balance_banks
  # GET /balance_banks.json
  def index
    @balance_banks = BalanceBank.all
  end

  # GET /balance_banks/1
  # GET /balance_banks/1.json
  def show
  end

  # GET /balance_banks/new
  def new
    @balance_bank = BalanceBank.new
  end

  # GET /balance_banks/1/edit
  def edit
  end

  # POST /balance_banks
  # POST /balance_banks.json
  def create
    @balance_bank = BalanceBank.new(balance_bank_params)

    respond_to do |format|
      if @balance_bank.save
        format.html { redirect_to @balance_bank, notice: 'Balance bank was successfully created.' }
        format.json { render :show, status: :created, location: @balance_bank }
      else
        format.html { render :new }
        format.json { render json: @balance_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /balance_banks/1
  # PATCH/PUT /balance_banks/1.json
  def update
    respond_to do |format|
      if @balance_bank.update(balance_bank_params)
        format.html { redirect_to @balance_bank, notice: 'Balance bank was successfully updated.' }
        format.json { render :show, status: :ok, location: @balance_bank }
      else
        format.html { render :edit }
        format.json { render json: @balance_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /balance_banks/1
  # DELETE /balance_banks/1.json
  def destroy
    @balance_bank.destroy
    respond_to do |format|
      format.html { redirect_to balance_banks_url, notice: 'Balance bank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_balance_bank
      @balance_bank = BalanceBank.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def balance_bank_params
      params.require(:balance_bank).permit(:balance, :balance_achieve, :code, :enable)
    end
end
