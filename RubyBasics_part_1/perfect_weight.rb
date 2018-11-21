puts "Введите ваше имя?"
user_name = gets.chomp.capitalize
puts "Введите ваш рост?"
height = gets.to_i
weight = height - 110
if weight < 0 
  then
   puts "#{user_name}, ваш вес уже оптимальный"
else
  puts "#{user_name}, ваш идеальный вес равен #{weight}"
end
