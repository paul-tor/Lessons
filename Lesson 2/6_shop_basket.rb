h = {}
fin_price = 0
loop do
    puts "Введите наименование товара: "
    name = gets.chomp
    break if name == 'стоп'
    puts "Введите цену за ед. товара: "
    p = gets.chomp.to_f
    puts "Введите количество товара: "
    q = gets.chomp.to_f
    h[name] = {:price => p, :quentity => q}
  end
puts h
h.each do|name, pr_quent|
    puts "\nИтого товар \"#{name}\" на сумму:"
    s = pr_quent[:price] * pr_quent[:quentity]
    puts "#{s} руб."
    fin_price += s
  end 
puts "\nСумма всех покупок: #{fin_price} руб."
