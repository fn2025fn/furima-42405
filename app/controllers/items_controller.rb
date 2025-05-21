class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :redirect_unless_authorized, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :delivery_time_id, :price, :image).merge(user_id: current_user.id)
  end

  def redirect_unless_authorized
    @item = Item.find(params[:id])
    redirect_to root_path if current_user != @item.user
  end
end
