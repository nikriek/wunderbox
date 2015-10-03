class OrderController < ApplicationController
  before_action :check_user_status
  
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to action: "congratulations"
    else 
      render :new
    end  
  end

  def congratulations
  end

  private 

    def order_params
      params.require(:order).permit(:category, :pricing)
    end

    def check_user_status
        unless user_signed_in?
        redirect_to root_path
      end
    end
end
