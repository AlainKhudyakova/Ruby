fibonacci = [0, 1]
while (new_number = fibonacci.last(2).sum) <= 100
   fibonacci << new_number
end
puts fibonacci.to_s
