sides = []

puts "Давайте определим какой треугольник."

print "Введите 1-ую сторону треугольника: "
sides << gets.to_f
print "Введите 2-ую сторону треугольника: "
sides << gets.to_f
print "Введите 3-ю сторону треугольника: "
sides << gets.to_f

sides.sort!

not_valid_triangle = sides[-1] >= sides[0] + sides[1]
right_triangle = sides[-1]**2 == sides[0]**2 + sides[1]**2
has_equal_cathetus = sides[0] == sides[1]
equilateral = sides[0] == sides[-1]

if not_valid_triangle
	puts "Треугольника с такими сторонам не существует"
elsif equilateral
	puts "Треугольник равносторонний"
elsif right_triangle && has_equal_cathetus
	puts "Треугольник прямоугольный и равнобедренный"
elsif right_triangle
	puts "Треугольник прямоугольный"
else
	puts "Треугольник не прямоугольный"
end
