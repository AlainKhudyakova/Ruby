
vowel_letters = ["а", "у", "о", "и", "э", "ы", "я", "ю", "е", "ё"]
vowels = {}

("а".."я").map.with_index do |letter, index|
   if vowel_letters.include?(letter)
      vowels[letter] = index+1
   end
end

puts vowels