puts "Введите основание треугольника:"
a = gets.chomp.to_f

puts "Введите высоту треугольника:"
h = gets.chomp.to_f
triangle_area = (a * h)/2

puts "Площадь треугольника: #{triangle_area}"