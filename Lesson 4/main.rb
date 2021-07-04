require_relative "station"
require_relative "route"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "passenger_carriage"
require_relative "cargo_carriage"
require_relative "actions"

user_act = Actions.new

loop do
  puts "\nВведите номер действия: \n1 - Создать станцию \n2 - Создать поезд \n3 - Создать маршрут \
        \n4 - Добавить, удалить станцию в маршруте \n5 - Назначить маршрут поезду \
        \n6 - Добавить вагон к поезду, отцепить вагон от поезда \
        \n7 - Переместить поезд по маршруту (вперед и назад) \n8 - Просмотреть список станций маршрута \
        \n9 - Посмотреть список поездов на  станции \nДля выхода - введите 'стоп'"
        
  user_input = gets.chomp

  case user_input
    when "1"
      user_act.cr_station
    when "2"
      user_act.cr_train
    when "3"
      user_act.cr_route
    when "4"
      user_act.act_with_st
    when "5"
      user_act.set_route
    when "6"
      user_act.act_with_carr
    when "7"
      user_act.act_with_tr
    when "8"
      user_act.st_view
    when "9"
      user_act.tr_view
  end
  break if user_input == "стоп"  
end




