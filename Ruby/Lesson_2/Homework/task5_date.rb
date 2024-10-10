puts "Введите день месяца"
day = gets.chomp.to_i
puts "Введите номер месяц"
month = gets.chomp.to_i
puts "Введите год"
year = gets.chomp.to_i

months = {
'01' => 31,
'02' => 28, 
'03' => 31, 
'04' => 30, 
'05' => 31,
'06' => 30,
'07' => 31,
'08' => 31,
'09' => 30,
'10' => 31,
'11' => 30,
'12' =>31
}

leap_year = (year % 4 == 0 && year % 100 !=0 ) || year % 400 == 0
months ["02"] = 29 if leap_year

number = day

months.each do |mm, dd|
   if month.to_i < mm.to_i
      number += dd
   end
end
puts "Найден порядковый номер даты: #{number}"