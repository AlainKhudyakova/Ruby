puts "Введите свое имя"
name = gets.chomp

puts "Введите свой рост"
height = gets.chomp.to_i
perfect_weight = (height - 110)* 1.15
if perfect_weight < 0
   puts "Ваш вес уже оптимальный."
else
   puts "#{name}, Ваш идеальный вес: #{perfect_weight}"
end
