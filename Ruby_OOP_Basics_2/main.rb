
require_relative 'train'
require_relative 'passengerTrain'
require_relative 'cargoTrain'
require_relative 'carriage'
require_relative 'passengerCarriage'
require_relative 'cargoCarriage'
require_relative 'station'
require_relative 'route'

class Main
  MAIN_MENU = <<~MAIN_QUESTIONS
    ------------------------------------------------------------
    |             Что бы Вы хотели сделать ?                   |
    |                                                          |
    |   Введите "1", если хотите создать поезд                 |
    |   Введите "2", если хотите создать станцию               |
    |   Введите "3", если хотите создать маршрут               |
    |                                                          |
    |   Введите "4", если хотите увидеть все поезда            |
    |   Введите "5", если хотите увидеть все станции           |
    |   Введите "6", если хотите увидеть все маршруты          |
    |                                                          |
    |   Введите "0", если хотите выйти из программы            |
    ------------------------------------------------------------
  MAIN_QUESTIONS

  WELCOME_MENU = <<~WELCOME_WORDS
    ------------------------------------------------------------
    |                                                          |
    |               Привет, дорогой пользователь!              |
    |            Приветствую тебя в программе "ЖелДор"         |
    |                                                          |
    ------------------------------------------------------------
  WELCOME_WORDS

  TRAIN_NUMBER_MENU = <<~TRAIN_NUMBER
    ------------------------------------------------------------
    |                  Вы решили создать поезд                 |
    |   Введите номер поезда:                                  |
    ------------------------------------------------------------
  TRAIN_NUMBER

  TRAIN_TYPE_MENU = <<~TRAIN_TYPE
    ------------------------------------------------------------
    |               Какой поезд вы хотите создать?             |
    |   Введите "1", если хотите создать грузовой              |
    |   Введите "2", если хотите создать пассажирский          |
    ------------------------------------------------------------
  TRAIN_TYPE

  TRAIN_ACTIONS_MENU = <<~TRAIN_ACTIONS
    ------------------------------------------------------------
    |        Какие действия с поездом Вы хотите сделать?       |
    |   Введите "1", если хотите добавить/отцепить вагон       |
    |   Введите "2", если хотите присвоить маршрут             |
    |   Введите "3", если хотите переместить поезд             |
    |                                                          |
    |   Введите "4", если хотите вернуться в главное меню      |
    ------------------------------------------------------------
  TRAIN_ACTIONS

  CHANGE_CARRIAGES_MENU = <<~CHANGE_CARRIAGES
    ------------------------------------------------------------
    |             Хотите добавить/отцепить вагоны?             |
    |   Введите "1", если хотите добавить вагон                |
    |   Введите "2", если хотите отцепить вагон                |
    |                                                          |
    |   Введите "3", если хотите вернуться в меню действий     |
    ------------------------------------------------------------
  CHANGE_CARRIAGES

  TRAIN_MOVE_MENU = <<~TRAIN_MOVE
    ------------------------------------------------------------
    |           В какую сторону двигаться по маршруту?         |
    |   Введите "1", если хотите двигаться вперед              |
    |   Введите "2", если хотите двигаться назад               |
    ------------------------------------------------------------
  TRAIN_MOVE

  STATION_MENU = <<~STATION_NAME
    ------------------------------------------------------------
    |                  Вы решили создать станцию               |
    |   Введите название станции:                              |
    ------------------------------------------------------------
  STATION_NAME

  STATION_DEPARTURE_MENU = <<~STATION_DEPARTUE
    ------------------------------------------------------------
    |                  Вы решили создать маршрут               |
    |   Выберите станцию отправления:                          |
    ------------------------------------------------------------
  STATION_DEPARTUE

  STATION_ARRIVAL_MENU = <<~STATION_ARRIVAL
    ------------------------------------------------------------
    |                  Вы решили создать маршрут               |
    |   Выберите станцию прибытия:                             |
    ------------------------------------------------------------
  STATION_ARRIVAL

  CHANGE_STATIONS_MENU = <<~CHANGE_STATIONS
    ------------------------------------------------------------
    |                  Вы решили создать маршрут               |
    |   Введите "1", если хотите включить станцию              |
    |   Введите "2", если хотите исключить станцию             |
    |   Введите "3", чтобы посмотреть станции маршрута         |
    |                                                          |
    |   Введите "4", если хотите вернуться в главное меню      |
    ------------------------------------------------------------
  CHANGE_STATIONS
  # инициации создания экземпляра класса
  def initialize
    @trains = []
    @stations = []
    @routes = []
  end
  # запуск программы
  def run
    puts WELCOME_MENU
    main_view
  end
  # методы с зоной видимости private, чтобы не было возможности вызывать методы напрямую
  private
  # экран основных действий программы
  def main_view
    loop do
    puts MAIN_MENU
    answer = gets.chomp
      case answer
      when "1"
        train_view
      when "2"
        station_view
      when "3"
        route_view
      when "4"
        all_trains_view
      when "5"
        alL_stations_view
      when "6"
        all_routes_view
      when "0"
        puts "Спасибо за использование программы 'ЖелДор'."
        break
      else
        puts "!! Некорректный ввод. !!"
      end
    end
  end 
  # экран создания поезда
  def train_view   
    puts TRAIN_NUMBER_MENU
    answer_number = gets.chomp

    loop do
      puts TRAIN_TYPE_MENU
      answer_type = gets.chomp
      case answer_type
      when "1"
        @trains << CargoTrain.new(answer_number)
        break
      when "2"
        @trains << PassengerTrain.new(answer_number)
        break
      else
        puts "!! Некорректный тип поезда !!"
      end
    end

    train_actions(@trains.last)
  end
  # метод с действиями с поездом
  def train_actions(train)
    loop do
      puts TRAIN_ACTIONS_MENU
      train_action = gets.chomp
      case train_action
      when "1"
        change_carriages(train)
      when "2"
        train_get_route(train)
      when "3"
        train_move(train)
      when "4"
        break
      else
        puts "!! Некорректный ввод !!"
      end
    end
  end
  # метод, вызывающий меню добавления/отцепления
  def change_carriages(train)
    loop do
      puts CHANGE_CARRIAGES_MENU
      carriages_answer = gets.chomp
      case carriages_answer
      when "1"
        carriage = CargoCarriage.new if train.type == :cargo
        carriage = PassengerCarriage.new if train.type == :passenger
        train.hook_carriage(carriage)
        puts "Вагон #{carriage} добавлен к поезду #{train.number}"
      when "2"
        return puts "У поезда нет вагонов" if train.carriages.empty?
        puts "Выберите вагон, который необходимо отцепить:"
        train.carriages.each { |carriage| puts "'#{train.carriages.index(carriage)}' если нужно отцепить вагон #{carriage}"}
        carriage_answer = train.carriages[gets.to_i]
        train.unhook_carriage(carriage_answer)
        puts "Вагон #{carriage_answer} отцеплен от поезда #{train.number}"
      when "3"
        break
      else
        "!! Некорректный ввод !!"
      end
    end
  end
  # метод для задания маршрута
  def train_get_route(train)
    if @routes.empty?
      puts "Сначала создайте маршрут"
    else
      puts "Выберите маршрут:"
      @routes.each { |route| puts "'#{@routes.index(route)}' если хотите выбрать маршрут #{route.stations[0].name} -> #{route.stations[-1].name}" }
      route_answer = @routes[gets.to_i]
      train.get_route(route_answer)
      puts "Поезд начал движение по маршруту '#{route_answer.stations[0].name}' -> '#{route_answer.stations[-1].name}'"
    end
  end
  # методя для перемещения поезда по маршруту
  def train_move(train)
    if train.route.nil? 
      puts "Сначала необходимо выбрать маршрут"
      train_actions
    end

    puts TRAIN_MOVE_MENU
    train_move_action = gets.chomp

    case train_move_action
    when "1"
      if train.next_station.nil?
        puts "Поезд находится на станции прибытия"
      else
        train.go_next_station
        puts "Поезд прибыл на станцию #{train.current_station.name}"
      end
    when "2"
      if train.previous_station.nil?
        puts "Поезд находится на станции отправления"
      else
        train.go_previous_station
        puts "Поезд прибыл на станцию #{train.current_station.name}"
      end
    else
      puts "!! Некорректный ввод !!"
    end
  end
  # Экран создания станции
  def station_view
    puts STATION_MENU
    station_name = gets.chomp
    @stations << Station.new(station_name)
  end
  # Экран создания маршрута
  def route_view
    station_departure = nil
    station_arrival = nil
    
    loop do
      puts STATION_DEPARTURE_MENU
      @stations.each { |station| puts "#{station.name}"}
      puts "--------------"
      station_departure_name = gets.chomp
      @stations.each { |station| station_departure = station if station.name == station_departure_name}
      if station_departure == nil
        puts "!! Некорректная станция отправления !!"
      else
        break
      end
    end

    loop do
      puts STATION_ARRIVAL_MENU
      @stations.each { |station| puts "#{station.name}"}
      puts "--------------"
      station_arrival_name = gets.chomp
      @stations.each { |station| station_arrival = station if station.name == station_arrival_name}
      if station_arrival == nil
        puts "!! Некорректная станция прибытия !!"
      else
        break
      end
    end
   
    @routes << Route.new(station_departure, station_arrival)

    puts "Создан маршрут: #{station_departure.name} -> #{station_arrival.name}"

    change_stations_view(@routes.last)
  end
  # Метод по добавлению станции в маршрут
  def change_stations_view(route)
    for_delete_station = nil
    for_add_station = nil
    
    loop do
      puts CHANGE_STATIONS_MENU
      change_stations_answer = gets.chomp
      case change_stations_answer
      when "1"
        puts "Выберите станцию:"
        @stations.each { |station| puts "  " + station.name}
        add_station_name = gets.chomp
        @stations.each { |station| for_add_station = station if station.name == add_station_name}
        if route.add_station(for_add_station).nil?
          puts "Нельзя добавить станцию в маршрут" 
        end
      when "2"
        puts "Выберите станцию:"
        @stations.each { |station| puts "  " + station.name}
        delete_station_name = gets.chomp
        @stations.each { |station| for_delete_station = station if station.name == delete_station_name}
        if route.delete_station(for_delete_station).nil?
          puts "Нельзя исключить станцию из маршрута" 
        end
      when "3"
        route.show_stations
      when "4"
        break
      else
        puts "!! Некорректный ввод !!"
      end
    end
  end 
  # Экран вывода всех поездов
  def all_trains_view
    puts "Список созданных поездов: "
    @trains.each { |train| puts " #{train.number}. Тип: #{train.type}. Количество вагонов: #{train.carriages.count}" }
  end
  # Экран вывода всех станций
  def alL_stations_view
    puts "Список созданных станция: "
    @stations.each do |station| 
      puts " #{station.name}"
      station.trains.each { |train| puts "  поезд: #{train.number}" }
    end
  end
  # Экран вывода всех маршрутов
  def all_routes_view
    puts "Список созданных маршрутов: "
    @routes.each do |route| 
      puts "Маршрут:  #{route.stations[0].name} -> #{route.stations[-1].name}"
      route.show_trains
    end
  end
end
