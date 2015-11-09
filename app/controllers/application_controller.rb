class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :category?

  def after_sign_in_path_for(resource)
    '/overview'
  end
  
  # 
  def transactions_getter(params)
    if category?(params)
      @transactions = Category.find(params[:category_id]).transactions.all
    else
      @transactions = Transaction.all
    end
  end

  # Helper for determining if the params was passed a top level category_id
  #
  def category?(params)
    params.has_key?(:category_id)
  end
end
