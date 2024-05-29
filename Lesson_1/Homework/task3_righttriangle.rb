puts "Введите 3 стороны треугольника:"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

def type_triangle (a,b,c)
   if (a**2 + b**2 == c**2)
      puts "Ваш треугольник прямоугольный"
   elsif (a == b && b == c)
      puts "Ваш треугольник равносторонний"
   elsif (a == b || b == c) 
      puts "Ваш треугольник равнобедренный"
   else
      puts "Ваш треугольник не прямоугольный"
   end
end
puts type_triangle(a,b,c)