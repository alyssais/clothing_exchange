class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    if user = params[:user_id]
      @items.where! user: User.find(params[:user_id])
    else
      @items.where!(closed: false)
    end

    if location = params[:sort].try(:[], :distance_from).presence
      @items = @items.near(location)
    else
      @items = @items.order(:created_at => :desc)
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
  end

  # GET /items/new
  def new
    @item = current_user.items.new
  end

  # GET /items/1/edit
  def edit
    @item = current_user.items.find(params[:id])
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create
    create_or_update current_user.items.new
  end

  def update
    create_or_update current_user.items.find(params[:id])
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:title, :description, :location, :closed)
  end
end
