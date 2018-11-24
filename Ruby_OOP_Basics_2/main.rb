
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
    |   Введите "7", если хотите выйти из программы            |
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
    |   Введите "1", если хотите добавить вагон                |
    |   Введите "2", если хотите отцепить вагон                |
    |   Введите "3", если хотите присвоить маршрут             |
    |   Введите "4", если хотите переместить поезд             |
    |                                                          |
    |   Введите "5", если хотите вернуться в главное меню      |
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
      answer = gets.to_i
      case answer
      when 1 then train_view
      when 2 then station_view
      when 3 then route_view
      when 4 then all_trains_view
      when 5 then alL_stations_view
      when 6 then all_routes_view
      when 7
        puts "Спасибо за использование программы 'ЖелДор'."
        break
      else puts "!! Некорректный ввод. !!"
      end
    end
  end 
  # экран создания поезда
  def train_view   
    puts TRAIN_NUMBER_MENU
    answer_number = gets.chomp

    loop do
      puts TRAIN_TYPE_MENU
      answer_type = gets.to_i
      case answer_type
      when 1
        @trains << CargoTrain.new(answer_number)
        break
      when 2
        @trains << PassengerTrain.new(answer_number)
        break
      else puts "!! Некорректный тип поезда !!"
      end
    end

    train_actions(@trains.last)
  end
  # метод с действиями с поездом
  def train_actions(train)
    loop do
      puts TRAIN_ACTIONS_MENU
      train_action = gets.to_i
      case train_action
      when 1 then hook_carriage(train)
      when 2 then unhook_carriage(train)
      when 3 then train_get_route(train)
      when 4 then train_move(train)
      when 5 then break
      else puts "!! Некорректный ввод !!"
      end
    end
  end
  # метод, вызывающий меню добавления вагона
  def hook_carriage(train)
    carriage = if train.is_a?(CargoTrain)
                 CargoCarriage.new
               elsif train.is_a?(PassengerTrain)
                 PassengerCarriage.new
               end
    train.hook_carriage(carriage)
    puts "Вагон #{carriage} добавлен к поезду #{train.number}"
  end
  # метод, вызывающий меню отцепления вагона
  def unhook_carriage(train)
    return puts "У поезда нет вагонов" if train.carriages.empty?
    puts "Выберите вагон, который необходимо отцепить:"
    train.carriages.each { |carriage| puts "'#{train.carriages.index(carriage)}' если нужно отцепить вагон #{carriage}"}
    carriage_answer = train.carriages[gets.to_i]
    train.unhook_carriage(carriage_answer)
    puts "Вагон #{carriage_answer} отцеплен от поезда #{train.number}"
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
      return
    end

    puts TRAIN_MOVE_MENU
    train_move_action = gets.to_i

    case train_move_action
    when 1
      if train.next_station.nil?
        puts "Поезд находится на станции прибытия"
      else
        train.go_next_station
        puts "Поезд прибыл на станцию #{train.current_station.name}"
      end
    when 2
      if train.previous_station.nil?
        puts "Поезд находится на станции отправления"
      else
        train.go_previous_station
        puts "Поезд прибыл на станцию #{train.current_station.name}"
      end
    else puts "!! Некорректный ввод !!"
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
      if station_departure.nil?
        puts " -- Выбор станции отправления --"
        station_departure = select_station(@stations)
      end

      if station_arrival.nil?
        puts " -- Выбор станции прибытия --"
        station_arrival = select_station(@stations)
      end

      if station_departure.nil? || station_arrival.nil?
        puts "!! Некорректный ввод !!"
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
    loop do
      puts CHANGE_STATIONS_MENU
      change_stations_answer = gets.to_i
      case change_stations_answer
      when 1 then add_station(route)
      when 2 then delete_station(route)
      when 3 then route.show_stations
      when 4 then break
      else puts "!! Некорректный ввод !!"
      end
    end
  end
  # Метод по добавлению стании в маршрут
  def add_station(route)
    station_for_include = select_station(@stations)
      if route.add_station(station_for_include).nil?
        puts "Нельзя добавить станцию в маршрут"
      end
  end
  # Метод по исключению станции из маршрута
  def delete_station(route)
    station_for_exclude = select_station(@stations)
      if route.delete_station(station_for_exclude).nil?
        puts "Нельзя исключить станцию из маршрута" 
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
      route.show_stations
    end
  end
  # метод выбора станции по введеному пользователем индексу
  def select_station(stations)
    puts "Выберите станцию: "
    stations.each_with_index { |station, index| puts " введите '#{index}', если: #{station.name}"}
    station_index = gets.to_i
    stations[station_index]
  end

end
