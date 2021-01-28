puts "Введите коэффициент а:"
a = gets.chomp.to_f
puts "Введите коэффициент b:"
b = gets.chomp.to_f
puts "Введите коэффициент c:"
c = gets.chomp.to_f
d = b**2 - 4 * a * c
if d > 0
  s = Math.sqrt(d)
  puts "Дискриминант = #{d}"
  puts "X1 = #{(s - b)/(2 * a)}"
  puts "X2 = #{(-s - b)/(2 * a)}"
elsif d == 0
  puts "Дискриминант = #{d}"
  puts "X1 = X2 = #{(-b)/(2 * a)}"
else 
  puts "Дискриминант = #{d}"
  puts "Корней нет"
end   
