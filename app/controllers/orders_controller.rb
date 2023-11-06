class OrdersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create show]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = 'Order was successfully created.'
    else
      flash.now[:alert] = 'Something went wrong. Please Try again.'
    end

    redirect_to new_order_path, notice: flash[:notice], alert: flash[:alert]
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :customer_name, :address, :zip_code, :shipping_method, :status)
  end
end
