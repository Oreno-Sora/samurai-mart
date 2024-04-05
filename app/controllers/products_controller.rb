class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :favorite]

  def index
     p 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiii'
    if sort_params.present?
      @sorted = sort_params[:sort]
      @category = Category.request_category(sort_params[:sort_category])
      @products = Product.sort_products(sort_params, params[:page])
    elsif params[:category].present?
      @category = Category.request_category(params[:category])
      @products = Product.category_products(@category, params[:page])
    else
      @products = Product.display_list(params[:page])
    end
    @categories = Category.all
    @major_category_names = Category.major_categories
    @sort_list = Product.sort_list
  end

  def show
    p 'sssssssssssssssssssssssssssssss'
    @reviews = @product.reviews_with_id    # 表示用すでにあるレビュー群
    @review = @reviews.new                 # 今回書き込み用レビュー
    @star_repeat_select = Review.star_repeat_select    # 評価入力用の雛形
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  def favorite
    current_user.toggle_like!(@product)
    redirect_to product_url @product
  end
  
  private

     def set_product
       @product = Product.find(params[:id])
     end

    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id)
    end
    
    def sort_params
      params.permit(:sort, :sort_category)
    end
end

