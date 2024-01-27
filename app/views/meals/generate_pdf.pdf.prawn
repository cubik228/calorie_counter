pdf.text @meal.name
pdf.text "Total Calories: #{@total_calories}"
pdf.text "Date: #{@meal.date}"

if @consumed_products.any?
  @consumed_products.each do |consumed_product|
    pdf.text "#{consumed_product.product.name} - #{consumed_product.quantity} calories"
  end
else
  pdf.text 'No consumed products for this meal.'
end