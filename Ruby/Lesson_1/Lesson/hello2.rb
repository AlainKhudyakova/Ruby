puts "Как Вас зовут?"
name = gets.chomp

puts "В каком году Вы родились?"
year = gets.chomp

puts "#{name}, привет! Тебе примерно #{2015 - year.to_i} лет." 
