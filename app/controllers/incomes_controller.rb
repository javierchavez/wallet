class IncomesController < ApplicationController
  before_action :set_income, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /incomes
  # GET /incomes.json
  def index
    @incomes = current_user.incomes.all
    @title = "All incomes"
  end

  # GET /incomes/1
  # GET /incomes/1.json
  def show
    
  end

  # GET /incomes/new
  def new
    @income = current_user.incomes.new
    @categories = current_user.categories.all
    @title = "Budget money for a category"
  end

  # GET /incomes/1/edit
  def edit
    @categories = current_user.categories.all
  end

  # POST /incomes
  # POST /incomes.json
  def create
    @income = current_user.incomes.new(income_params)
    
    respond_to do |format|
      if @income.save
        format.html { redirect_to @income, notice: 'Income was successfully created.' }
        format.json { render :show, status: :created, location: @income }
        format.js { render :show, status: :created, location: @income }
      else
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incomes/1
  # PATCH/PUT /incomes/1.json
  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to @income, notice: 'Income was successfully updated.' }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.json
  def destroy
    @income.destroy
    respond_to do |format|
      format.html { redirect_to incomes_url, notice: 'Income was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_income
      @income = Income.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def income_params
      params.require(:income).permit(:amount, :category_id, :name)
    end
end
