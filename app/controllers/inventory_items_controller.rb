class InventoryItemsController < ApplicationController
  before_action :set_inventory_item, only: [:show, :edit, :update, :destroy]

  def import
  end

  def process_import
    @logger = Imports::UserInterfaceImport.import_spreadsheet(
      params[:import_file],
      Imports::Runners::ImportNewRecord,
      Imports::Mappings::InventoryItem
    )
    if @logger.errors?
      @inventory_items = InventoryItem.all
      render action: :import
    else
      flash[:success] = 'Inventory Items imported successfully'
      redirect_to action: :index
    end
  end

  def index
    @inventory_items = InventoryItem.all
  end

  def show
  end

  def new
    @inventory_item = InventoryItem.new
  end

  def edit
  end

  def create
    @inventory_item = InventoryItem.new(inventory_item_params)

    respond_to do |format|
      if @inventory_item.save
        format.html { redirect_to @inventory_item, notice: 'Inventory item was successfully created.' }
        format.json { render :show, status: :created, location: @inventory_item }
      else
        format.html { render :new }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @inventory_item.update(inventory_item_params)
        format.html { redirect_to @inventory_item, notice: 'Inventory item was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventory_item }
      else
        format.html { render :edit }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inventory_item.destroy
    respond_to do |format|
      format.html { redirect_to inventory_items_url, notice: 'Inventory item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_inventory_item
      @inventory_item = InventoryItem.find(params[:id])
    end

    def inventory_item_params
      params.require(:inventory_item).permit(:name, :description, :quantity, :unit_price, :enabled, :sku_code)
    end
end
