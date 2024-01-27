# app/controllers/meals_controller.rb
class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def index
    @meals = Meal.all
  end

  def show
    unless @meal
      redirect_to meals_path, alert: "Meal not found."
      return
    end
  
    @consumed_products = @meal.consumed_products
    @total_calories = @consumed_products.sum(:quantity)
  end
  

  def new
    @meal = Meal.new
  end

  def create
    @meal = current_user.meals.build(meal_params)

    if @meal.save
      redirect_to meal_path(@meal), notice: 'Meal was successfully created.'
    else
      render :new
    end
  end

  def edit
    @meal = Meal.find(params[:id])
  end

  def update
    if @meal.update(meal_params)
      redirect_to meal_path(@meal), notice: 'Meal was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @meal.destroy
    redirect_to meals_path, notice: 'Meal was successfully destroyed.'
  end

  def add_product
    @meal = current_user.meals.find(params[:id])
    @consumed_product = @meal.consumed_products.build
    @products = Product.all
  end

  def create_consumed_product
    @meal = current_user.meals.find(params[:id])
    @consumed_product = @meal.consumed_products.build(consumed_product_params)
  
    selected_product = Product.find(@consumed_product.product_id)
  
    @consumed_product.quantity = selected_product.calories_count
  
    if @consumed_product.save
      redirect_to meal_path(@meal), notice: 'Product added to meal.'
    else
      @products = Product.all
      render 'add_product'
    end
  end

  def destroy_consumed_product
    @meal = current_user.meals.find(params[:id])
    @consumed_product = @meal.consumed_products.find(params[:consumed_product_id])
    
    @consumed_product.destroy
  
    redirect_to meal_path(@meal), notice: 'Product removed from meal.'
  end

  private

  def consumed_product_params
    params.require(:consumed_product).permit(:product_id, :quantity)
  end
  

  def set_meal
    @meal = current_user.meals.find_by(id: params[:id])
  
    unless @meal
      redirect_to meals_path, alert: "Meal not found."
    end
  end
  
  

  def meal_params
    params.require(:meal).permit(:name, :total_calories, :date)
  end
end
