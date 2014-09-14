class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  # GET /orders
  # GET /orders.json
  def index
    if current_user.try(:admin?)

      @orders = Order.all
    else
      @orders = current_user.orders.all
    end

  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    flash[:notice] = "Order Created Successfully."
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def notification
  @notification = Twocheckout::ValidateResponse.notification({:sale_id => params['sale_id'], :vendor_id => 1817037,
                                                              :invoice_id => params['invoice_id'], :secret => "tango", :md5_hash => params['md5_hash']})
  @order = Order.find_by_order_number(params['sale_id'])
  if params['message_type'] == "FRAUD_STATUS_CHANGED"
    begin
      if @notification['code'] == "PASS" and params['fraud_status'] == "pass"
        @order.status = "success"
        render :text =>"Fraud Status Passed"
      else
        @order.status = "failed"
        render :text =>"Fraud Status Failed or MD5 Hash does not match!"
      end
    ensure
      @order.save
    end
  end
end

def refund
  @order = Order.find(params[:id])
  begin
    Twocheckout::API.credentials = { :username => 'APIuser1817037', :password => 'APIpass1817037' }
    @sale = Twocheckout::Sale.find(:sale_id => @order.order_number)
    @response = @sale.refund!({:comment => "Item(s) not available", :category => 6})
    @order.status = "refunded"
    @order.save
    flash[:notice] = @response[:response_message]
    redirect_to orders_path
  rescue Exception => e
    flash[:notice] = e.message
    redirect_to orders_path
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:id, :total, :card_holder_name, :order_number)
    end
end
