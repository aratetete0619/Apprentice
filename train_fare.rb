def train_fare(age)
  if age >= 12
    puts 200
  elsif 12 > age && age >= 6
    puts 100
  elsif 6 > age && age > 0
    puts 0
  end
end

train_fare(12)
train_fare(6)
train_fare(5)
