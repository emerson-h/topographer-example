class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]

  def import
  end

  def process_import
    data_file = params[:import_file].tempfile.path
    importer = Importers::UserInterface.new(
      file: data_file,
      mapping: Importers::Orders::Mapping.new,
      strategy: Importers::Orders::Strategy.new
    )
    if !importer.import
      @inventory_items = InventoryItem.all
      @errors = importer.errors
      render action: :import
    else
      flash[:success] = 'Inventory Items imported successfully'
      redirect_to action: :index
    end
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end


  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_number, :ordered_at, :on_hold)
    end
end
