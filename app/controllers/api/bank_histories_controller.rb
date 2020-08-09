class Api::BankHistoriesController < ApplicationController
  before_action :set_bank_history, only: [:show, :edit, :update, :destroy]

  # GET /bank_histories
  # GET /bank_histories.json
  def index
    @bank_histories = BankHistory.all
  end

  # GET /bank_histories/1
  # GET /bank_histories/1.json
  def show
  end

  # GET /bank_histories/new
  def new
    @bank_history = BankHistory.new
  end

  # GET /bank_histories/1/edit
  def edit
  end

  # POST /bank_histories
  # POST /bank_histories.json
  def create
    @bank_history = BankHistory.new(bank_history_params)

    respond_to do |format|
      if @bank_history.save
        format.html { redirect_to @bank_history, notice: 'Bank history was successfully created.' }
        format.json { render :show, status: :created, location: @bank_history }
      else
        format.html { render :new }
        format.json { render json: @bank_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_histories/1
  # PATCH/PUT /bank_histories/1.json
  def update
    respond_to do |format|
      if @bank_history.update(bank_history_params)
        format.html { redirect_to @bank_history, notice: 'Bank history was successfully updated.' }
        format.json { render :show, status: :ok, location: @bank_history }
      else
        format.html { render :edit }
        format.json { render json: @bank_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_histories/1
  # DELETE /bank_histories/1.json
  def destroy
    @bank_history.destroy
    respond_to do |format|
      format.html { redirect_to bank_histories_url, notice: 'Bank history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_history
      @bank_history = BankHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_history_params
      params.require(:bank_history).permit(:balance_bank_id, :balance_before, :balance_after, :activity, :ip, :location, :user_agent, :author)
    end
end
