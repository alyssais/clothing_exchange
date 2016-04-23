class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    if location = params[:sort].try(:[], :distance_from).presence
      @items = @items.near(location)
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create
    create_or_update Item.new
  end

  def update
    create_or_update Item.find(params[:id])
  end

  private

  def create_or_update(item)
    item.assign_attributes(item_params)
    respond_to do |format|
      @item = item
      if item.save
        format.html { redirect_to item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: item }
      else
        format.html { render :edit }
        format.json { render json: item.errors, status: :unprocessable_entity }
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:title, :description, :email, :location)
  end
end
