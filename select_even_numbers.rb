def select_even_numbers(numbers)
  print numbers.select{ |num| num.even?}
end


select_even_numbers([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
