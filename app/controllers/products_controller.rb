# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[update destroy]

  def index
    @products = if params[:search].present?
                  Product.where('name LIKE ?', "%#{params[:search]}%")
                else
                  Product.all
                end
  end
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    if @product.update(product_params)
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @product
      @product.destroy
      redirect_to products_path, notice: 'Product was successfully destroyed.'
    else
      redirect_to products_path, alert: 'Product not found.'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :calories_count)
  end

  def set_product
    @product = Product.find_by(id: params[:id])
  end
end
