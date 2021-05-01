class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_BASIC_AUTH_USER"], password: ENV["HTTP_BASIC_AUTH_PASSWORD"]

  
  def index
    @category = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Çategory.new(product_params)
    
    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  # private

  # def product_params
  #   params.require(:product).permit(
  #     :name,
  #     :description,
  #     :category_id,
  #     :quantity,
  #     :image,
  #     :price
  #   )
  # end

end
