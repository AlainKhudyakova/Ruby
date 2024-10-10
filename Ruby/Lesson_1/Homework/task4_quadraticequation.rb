puts "Введите 3 коэффициента"
a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

def result (a,b,c)
d = b**2 - 4 * a * c 
if d < 0
   puts "Корней нет!"
elsif d == 0
   puts "Дискриминант = #{d}, и корень #{-b/(2 * a)}"
else 
   puts "Дискриминант = #{d}, Корень 1 = #{(-b - Math.sqrt(d))/(a * 2)} Корень 2 = #{(-b - Math.sqrt(d))/(a * 2)}"
   end
end
puts result(a,b,c)
