class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]


  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart = current_cart
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])

  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.json { head :no_content }
    end
  end

  def return
    @notification = Twocheckout::ValidateResponse.purchase({:sid => 1817037, :secret => "tango",
                                                            :order_number => params['order_number'], :total => params['total'], :key => params['key']})

    @cart = Cart.find(params['merchant_order_id'])
    begin
      # if @notification[:code] == "PASS"
        @cart.status = 'success'
        @cart.purchased_at = Time.now
        @order = current_user.orders.create(:total => params['total'],
                              :card_holder_name => params['card_holder_name'],
                              :status => 'pending',
                              :order_number => params['order_number'],
                              :user_id => current_user.id)
        reset_session
        flash[:notice] = "Your order was successful! We will contact you directly to confirm before delivery."
        redirect_to root_path
      # else
      #   @cart.status = "failed"
      #   flash[:notice] = "Error validating order, please contact us for assistance."
      #   redirect_to root_url
      # end
    ensure
      @cart.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:purchased_at, :status)
    end
end
