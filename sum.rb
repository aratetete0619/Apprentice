def sum(x, y)
  sum = 0
  (x..y).each do |i|
    sum += i
  end
  puts sum
end


sum(10 ,80)
