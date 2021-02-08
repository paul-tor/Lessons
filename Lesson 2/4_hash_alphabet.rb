hash = {}
arr2 = ['А', 'Е', 'И', 'О', 'У', 'Ы', 'Э', 'Ю', 'Я']
arr1 = ('А'..'Я').to_a
arr1.each_with_index do |letter, index|
  hash[letter] = index + 1 if arr2.include?(letter)
end 
puts hash
