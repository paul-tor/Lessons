puts "Введите первую сторону треугольника:"
x1 = gets.chomp.to_f
puts "Введите вторую сторону треугольника (в тех же единицах, что и первую сторону):"
x2 = gets.chomp.to_f
puts "Введите третью сторону треугольника (в тех же единицах, что и первую сторону):"
x3 = gets.chomp.to_f
  #Проверим, является ли треугольник прямоугольным:
  #Пусть c - самая большая сторона треугольника, а и b - остальные стороны треугольника.
if x1 > x2 && x1 >x3
  c = x1
  a = x2
  b = x3
elsif x2 > x1 && x2 > x3
  c = x2
  a = x1
  b = x3  
else x3 > x1 && x3 >x2
  c = x3
  a = x2
  b = x1
end
  #Проверяем прямоуголность треугольника с помощью формулы Пифагора:
if c**2 == (a**2 + b**2)
  puts "Треугольник прямоугольный"
else
  puts "Треугольник не прямоугольный"
end
  #Проверим, является ли треугольник равнобедренным:
if x1 == x2 || x1 == x3 || x3 == x2
  puts "Треугольник равнобедренный"
end
  #Проверим, является ли треугольник равносторонним:
if x1 == x2 && x2 == x3 && x1 == x3
  puts "Треугольник равносторонний"
end
