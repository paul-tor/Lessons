
puts "Введите год: "
year = gets.chomp.to_i
year_is_true = year >= 0

puts "Введите порядковый номер месяца (от 1 до 12): "
month = gets.chomp.to_i
month_is_true = (month <= 12 && month >= 1)

months_arr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap_year = (year%400 == 0 || (year%4 == 0 && year%100 != 0))
months_arr[1] = 29 if leap_year

puts "Введите число (от 1 до 31): "
date = gets.chomp.to_i
date_is_true = (date <= 31 && date >= 1 && date == months_arr[month-1])
 
if  year_is_true && month_is_true && date_is_true
  i = 0
  j = 0
    while i < month-1 do
      j += months_arr[i]
      i += 1
    end
  puts "Порядковый номер даты: #{j + date}"
else
  puts "Ошибка ввода: проверьте введённые значения. Год - положительное число; месяц - число от 1 до 12; дата - от 1 до 31 и количество дней соответсвует месяцу и високосности года"
end
