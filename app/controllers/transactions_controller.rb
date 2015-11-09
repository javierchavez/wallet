# coding: utf-8
class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /transactions
  # GET /transactions.json
  def index
    transactions_getter(params)

    # this is for displaying the transaction form on the main page
    @transaction = current_user.transactions.new
    @categories = current_user.categories.all
    @title = "Log a cost for a category"
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @title = "Log a cost for a category"
    @transaction = current_user.transactions.new
    @categories = current_user.categories.all
  end

  # GET /transactions/1/edit
  def edit
    @categories = current_user.categories.all
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @categories = current_user.categories.all

    if category?(params)
      @transaction = current_user.categories.find(params[:category_id]).transactions.new(transaction_params)
    else
      @transaction = current_user.transactions.new(transaction_params)
    end

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params
    params.require(:transaction).permit(:name, :category_id, :amount)
  end
end
