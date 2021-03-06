class ItemsController < ApplicationController
  before_action :set_item, only: [:confirm, :show, :destroy, :edit, :update]

  before_action :set_parent_category
  before_action :set_parent_array, only: [:new, :create, :edit, :update]
  require 'payjp'

  def index
    @items = Item.last(4)
    @brandItems = Item.where("brand IS NOT NULL").last(4)
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '出品が完了しました'
    else
      flash.now[:alert] = '正しく入力してください。'
      @item.images.new
      set_children_and_grandchildren_array_and_parent_category
      render :new
    end
  end

  def edit
    if current_user && current_user.id != @item.seller_id
      redirect_to root_path
    end
    set_children_and_grandchildren_array_and_parent_category
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      flash.now[:alert] = '正しく入力してください。'
      set_children_and_grandchildren_array_and_parent_category
      render 'items/edit'
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to :show
    end
  end

  def confirm
  end

  def show
    @items = Item.all
    @relatedItems = Item.where(category_id: @item.category_id).where.not(id: params[:id]).order("RAND()").limit(3)
    @seller = User.find_by(id: @item.seller_id)
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end
  
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end


  # private


  def set_item
    @item = Item.find(params[:id])
  end
  
  def set_parent_array
    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent
    end
  end

  def set_parent_category
    @parents = Category.where(ancestry: nil)
  end

  def set_children_and_grandchildren_array_and_parent_category
    if @item.category
      @grandchild_category = @item.category
      @child_category = @grandchild_category.parent
      @parent_category = @grandchild_category.root

      @child_category_array = []
      @item.category.parent.siblings.each do |children|
        @child_category_array << children
      end

      @grandchild_category_array = []
      @item.category.siblings.each do |grandchildren|
        @grandchild_category_array << grandchildren
      end
    end
  end

  def purchase
    @item = Item.find(params[:id])
    @card = current_user.credit_card.customer_id
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
    Payjp::Charge.create(
      amount: @item.price,
      customer: @card,
      currency: 'jpy'
    )
    @item.update( buyer_id: current_user.id)
    redirect_to root_path
    flash[:notice] = '商品の購入が完了しました'
  end

  private

  def item_params
    params.require(:item).permit(:name, :content, :brand, :category_id, :condition, :postage_payer, :postage_type, :prefecture_id, :preparation_day, :price, images_attributes: [:image_url, :_destroy, :id]).merge(seller_id: current_user.id)
  end

end
