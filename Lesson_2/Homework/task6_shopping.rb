goods = {}
result = 0 

loop do
   puts "Введите название товара:"
   title = gets.chomp.to_s
break unless title != "стоп"

puts "Введите цену:"
price = gets.chomp.to_f
puts "Введите количество:"
quantity = gets.chomp.to_f

goods[title] = {price: price, quantity: quantity, sum: price * quantity}
result += price * quantity 
end
puts goods
puts "Итого : #{result}" 