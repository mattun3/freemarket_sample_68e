class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]
  before_action :set_category, only: [:show, :edit]
  skip_before_action :set_product, only: [:get_category_children, :get_category_grandchildren]
  
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @products = Product.includes(:images).order('created_at DESC')
    @category = Product.order('created_at desc').limit(3)
  end

  def new
    @product = Product.new
    @product.images.new
    @categories = Category.all
    #データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
  end

  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    # ここでfind_byを使うことでレディーしか取れてなかった
    @category_children = Category.find(params[:parent_id]).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render "products/product_error"
    end
  end

  def show
  end

  def edit
    render :new
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render "products/product_error"
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(
      :name, 
      :category_id, 
      :text, 
      :brand, 
      :status, 
      :shippingcharges, 
      :shipping_area, 
      :days_to_ship, 
      :price,
      images_attributes: [:image, :_destroy, :id]
    )
    .merge(user_id: current_user.id)
  end
  
  def set_product
    @product = Product.find(params[:id])
  end

  def set_category
    @category = @product.category
  end

  def currect_user
    if current_user.id != @product.user_id
      redirect_to root_path
    end
  end

end