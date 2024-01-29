# frozen_string_literal: true

# app/controllers/meals_controller.rb
class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal,
                only: %i[show edit update destroy add_product destroy_consumed_product create_consumed_product]

  def index
    @meals = current_user.meals
  end

  def show
    @consumed_products = @meal.consumed_products
    @total_calories = @consumed_products.sum(:quantity)
  end

  def generate_pdf
    @meal = current_user.meals.find_by(id: params[:id])
    @consumed_products = @meal.consumed_products
    @total_calories = @consumed_products.sum(:quantity)

    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new

        pdf.font 'Helvetica', size: 18
        pdf.text 'Meal Report', align: :center
        pdf.move_down 10

        pdf.font 'Helvetica', size: 14
        pdf.text "Name: #{@meal.name}"
        pdf.text "Total Calories: #{@total_calories}"
        pdf.text "Date: #{@meal.date}"
        pdf.move_down 20

        if @consumed_products.any?
          pdf.font 'Helvetica', size: 12
          pdf.text 'Consumed Products:', style: :italic
          @consumed_products.each do |consumed_product|
            pdf.text "#{consumed_product.product.name} - #{consumed_product.quantity} calories", indent_paragraphs: 20
          end
        else
          pdf.font 'Helvetica', size: 12, style: :italic
          pdf.text 'No consumed products for this meal.'
        end

        send_data pdf.render, filename: 'meal_report.pdf', type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def new
    @meal = current_user.meals.build
  end

  def create
    @meal = current_user.meals.build(meal_params)

    if @meal.save
      redirect_to meal_path(@meal), notice: 'Meal was successfully created.'
    else
      render :new
    end
  end

  def edit; end

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
    @consumed_product = @meal.consumed_products.build
    @products = Product.all
  end

  def create_consumed_product
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

    return if @meal

    redirect_to meals_path, alert: 'Meal not found.'
  end

  def meal_params
    params.require(:meal).permit(:name, :total_calories, :date)
  end
end
