class OrderController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to :congratulations_url
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
end
