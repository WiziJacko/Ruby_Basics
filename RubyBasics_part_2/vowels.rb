# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ('а'..'я').to_a
alphabet.insert(6, 'ё')
vowels_arr = %w[а е ё и о у ы э ю я]
vowels_hash = {}

alphabet.each.with_index(1) do |value, index|
  vowels_hash[value] = index if vowels_arr.include?(value)
end

puts vowels_hash
