puts "Введите cвоё имя:"
name = gets.chomps
puts "Введите свой рост, см:"
weight = gets.chomp.to_i
ideal_weight = (weight-110)*1.15
if ideal_weight > 0
  puts "#{name}, Ваш идеальный вес = #{ideal_weight} кг"
else 
  puts "Ваш вес уже оптимальный"
end  
