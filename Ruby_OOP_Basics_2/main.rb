
require_relative 'train'
require_relative 'passengerTrain'
require_relative 'cargoTrain'
require_relative 'carriage'
require_relative 'passengerCarriage'
require_relative 'cargoCarriage'
require_relative 'station'
require_relative 'route'

@main_menu = <<~questions
	------------------------------------------------------------
	|             Что бы Вы хотели сделать ?                   |
	|                                                          |
	| Введите "поезд", если хотите создать поезд               |
	| Введите "станция", если хотите создать станцию           |
	| Введите "маршрут", если хотите создать маршрут           |
	|                                                          |
	| Введите "все поезда", если хотите увидеть все поезде     |
	| Введите "все станции", если хотите увидеть все станции   |
	| Введите "все маршруты", если хотите увидеть все маршруты |
	|                                                          |
	| Введите "выход", если хотите выйти из программы          |
	------------------------------------------------------------
questions

common_part = <<~common_part
	------------------------------------------------------------
	|                                                          |
	|               Привет, дорогой пользователь!              |
	|            Приветствую тебя в программе "ЖелДор"         |
	|                                                          |
	------------------------------------------------------------
common_part

puts common_part
# Экран основных действий программы
def main_view
  
  puts @main_menu
  answer = gets.chomp
  answer.downcase!

  case answer
    when "поезд"
      train_view
    when "станция"
      station_view
    when "маршрут"
      route_view
    when "все поезда"
      all_trains_view
    when "все станции"
      alL_stations_view
    when "все маршруты"
      all_routes_view
    when "выход"
      puts "Спасибо за использование программы 'ЖелДор'."
      exit
    else
      puts "!! Некорректный ввод. !!"
      main_view
  end
end 
# Экран создания поезда
def train_view
  # Создаем переменную до вопроса пользователю, чтобы можно было добавить логику на проверку этой переменной и в дальнейшем
  # не повторить запрос номера, если некорректно введен тип
  @answer_number ||= ''
  train_number_menu = <<~train_number_menu
	------------------------------------------------------------
	|                  Вы решили создать поезд                 |
	| Введите номер поезда:                                    |
	------------------------------------------------------------
  train_number_menu
  
  if @answer_number.empty?
  	puts train_number_menu
    @answer_number = gets.chomp
  end

  train_type_menu = <<~train_type_menu
	------------------------------------------------------------
	|               Какой поезд вы хотите создать?             |
	| Введите "грузовой", если хотите создать грузовой         |
	| Введите "пассажирский", если хотите создать пассажирский |
	------------------------------------------------------------
  train_type_menu

  puts train_type_menu
  answer_type = gets.chomp
  answer_type.downcase!

  case answer_type
    when "грузовой"
      @trains << CargoTrain.new(@answer_number)
    when "пассажирский"
      @trains << PassengerTrain.new(@answer_number)
    else
      puts "!! Некорректный тип поезда !!"
      train_view
  end

  @answer_number = ''
  @train = @trains.last

  train_actions
end
# метод с действиями с поездом
def train_actions
  train_actions_menu = <<~train_actions_menu
	------------------------------------------------------------
	|        Какие действия с поездом Вы хотите сделать?       |
	| Введите "вагоны", если хотите добавить/отцепить вагон    |
	| Введите "маршрут", если хотите присвоить маршрут         |
	| Введите "двигаться", если хотите переместить поезд       |
	|                                                          |
	| Введите "меню", если хотите вернуться в главное меню     |
	------------------------------------------------------------
  train_actions_menu

  puts train_actions_menu
  train_action = gets.chomp
  train_action.downcase!

  case train_action
    when "вагоны"
      change_carriages
    when "маршрут"
      train_get_route
    when "двигаться"
      train_move
    when "меню"
      main_view
    else
      puts "!! Некорректный ввод !!"
      train_actions
  end
end
# метод, вызывающий меню добавления/отцепления
def change_carriages
  change_carriages_menu = <<~change_carriages_menu
	------------------------------------------------------------
	|             Хотите добавить/отцепить вагоны?             |
	| Введите "добавить", если хотите добавить вагон           |
	| Введите "отцепить", если хотите отцепить вагон           |
	|                                                          |
	| Введите "действия", если хотите вернуться в меню действий|
	------------------------------------------------------------
  change_carriages_menu

  puts change_carriages_menu
  carriages_answer = gets.chomp
  carriages_answer.downcase!

  case carriages_answer
    when "добавить"
      carriage = CargoCarriage.new if @train.type == :cargo
      carriage = PassengerCarriage.new if @train.type == :passenger
      @train.hook_carriage(carriage)
      puts "Вагон #{carriage} добавлен к поезду #{@train.number}"
    when "отцепить"
      return puts "У поезда нет вагонов" if @train.carriages.empty?
      puts "Выберите вагон, который необходимо отцепить:"
      @train.carriages.each { |carriage| puts "'#{@train.carriages.index(carriage)}' если нужно отцепить вагон #{carriage}"}
      carriage_answer = @train.carriages[gets.to_i]
      @train.unhook_carriage(carriage_answer)
      puts "Вагон #{carriage_answer} отцеплен от поезда #{@train.number}"
    when "действия"
      train_actions
    else
      "!! Некорректный ввод !!"
      change_carriages
  end

  change_carriages
end
# метод для задания маршрута
def train_get_route
  if @routes.empty?
    puts "Сначала создайте маршрут"
    train_actions
  else
    puts "Выберите маршрут:"
    @routes.each { |route| puts "'#{@routes.index(route)}' если хотите выбрать маршрут #{route.stations[0].name} -> #{route.stations[-1].name}" }
    route_answer = @routes[gets.to_i]
    @train.get_route(route_answer)
    puts "Поезд начал движение по маршруту '#{route_answer.stations[0].name}' -> '#{route_answer.stations[-1].name}'"
    train_actions
  end
end
# методя для перемещения поезда по маршруту
def train_move
  train_move_menu = <<~train_move_menu
	------------------------------------------------------------
	|           В какую сторону двигаться по маршруту?         |
	| Введите "вперед", если хотите двигаться вперед           |
	| Введите "назад", если хотите двигаться назад             |
	------------------------------------------------------------
  train_move_menu

  if @train.route.nil? 
  	puts "Сначала необходимо выбрать маршрут"
  	train_actions
  end

  puts train_move_menu
  train_move_action = gets.chomp
  train_move_action.downcase!

  case train_move_action
    when "вперед"
      if @train.next_station.nil?
      	puts "Поезд находится на станции прибытия"
      else
       @train.go_next_station
      	puts "Поезд прибыл на станцию #{@train.current_station.name}"
      end
    when "назад"
      if @train.previous_station.nil?
      	puts "Поезд находится на станции отправления"
      else
       @train.go_previous_station
      	puts "Поезд прибыл на станцию #{@train.current_station.name}"
      end
    else
      puts "!! Некорректный ввод !!"
  end
 
  train_actions
end
# Экран создания станции
def station_view
  station_menu = <<~station_menu
	------------------------------------------------------------
	|                  Вы решили создать станцию               |
	| Введите название станции:                                |
	------------------------------------------------------------
  station_menu

  puts station_menu
  station_name = gets.chomp
  @stations << Station.new(station_name)

  main_view
end
# Экран создания маршрута
def route_view

  @station_departure ||= nil
  @station_arrival ||= nil
  
  station_departure_menu = <<~station_departure_menu
	------------------------------------------------------------
	|                  Вы решили создать маршрут               |
	| Выберите станцию отправления:                            |
	------------------------------------------------------------
  station_departure_menu
  
  if @station_departure.nil?
    puts station_departure_menu
    @stations.each { |station| puts "#{station.name}"}
    puts "--------------"
    station_departure_name = gets.chomp
    @stations.each { |station| @station_departure = station if station.name == station_departure_name}
  end

  if @station_departure.nil?
  	puts "!! Некорректная станция отправления !!"
  	route_view
  end

  station_arrival_menu = <<~station_arrival_menu
	------------------------------------------------------------
	|                  Вы решили создать маршрут               |
	| Выберите станцию прибытия:                               |
	------------------------------------------------------------
  station_arrival_menu

  puts station_arrival_menu
  @stations.each { |station| puts "#{station.name}"}
  puts "--------------"
  station_arrival_name = gets.chomp
  @stations.each { |station| @station_arrival = station if station.name == station_arrival_name}

  if @station_arrival.nil?
  	puts "!! Некорректная станция прибытия !!"
  	route_view
  end
  
  @route = Route.new(@station_departure, @station_arrival)
  @routes << @route

  puts "Создан маршрут: #{@station_departure.name} -> #{@station_arrival.name}"

  @station_departure = nil
  @station_arrival = nil

  change_stations_view
end
# Метод по добавлению станции в маршрут
def change_stations_view
  change_stations_menu = <<~change_stations_menu
	------------------------------------------------------------
	|                  Вы решили создать маршрут               |
	| Введите "исключить", если хотите исключить станцию       |
	| Введите "включить", если хотите включить станцию         |
	| Введите "станции", чтобы посмотреть станции маршрута     |
	|                                                          |
	| Введите "меню", если хотите вернуться в главное меню     |
	------------------------------------------------------------
  change_stations_menu

  puts change_stations_menu
  change_stations_answer = gets.chomp
  change_stations_answer.downcase!

  case change_stations_answer
    when "включить"
      puts "Выберите станцию:"
      @stations.each { |station| puts "  " + station.name}
      add_station_name = gets.chomp
      @stations.each { |station| @add_station = station if station.name == add_station_name}
      if @route.add_station(@add_station).nil?
        puts "Нельзя добавить станцию в маршрут" 
      end
      change_stations_view
    when "исключить"
      puts "Выберите станцию:"
      @stations.each { |station| puts "  " + station.name}
      delete_station_name = gets.chomp
      @stations.each { |station| @delete_station = station if station.name == delete_station_name}
      if @route.delete_station(@delete_station).nil?
        puts "Нельзя исключить станцию из маршрута" 
      end
      change_stations_view
    when "станции"
      @route.show_stations
      change_stations_view
    when "меню"
      main_view
    else
      puts "!! Некорректный ввод !!"
      change_stations_view
  end
end 
# Экран вывода всех поездов
def all_trains_view
  puts "Список созданных поездов: "
  @trains.each { |train| puts " #{train.number}. Тип: #{train.type}. Количество вагонов: #{train.carriages.count}" }

  main_view
end
# Экран вывода всех станций
def alL_stations_view
  puts "Список созданных станция: "
  @stations.each do |station| 
    puts " #{station.name}"
    station.trains.each { |train| puts "  поезд: #{train.number}" }
  end

  main_view
end
# Экран вывода всех маршрутов
def all_routes_view
  puts "Список созданных маршрутов: "
  @routes.each { |route| puts " #{route.stations[0].name} -> #{route.stations[-1].name}" }

  main_view
end

# Запуск программы
@trains = []
@stations = []
@routes = []

main_view
