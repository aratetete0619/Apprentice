def fibonacci(n)
   if n >= 2
    array = [{0 => 0}, {1 => 1}]
    (2..n).each do |i|
      array << {i => array[i-1].values[0] + array[i-2].values[0]}
    end
    puts array[n].values[0]
  elsif n == 1 || n == 0
    puts n
  end
end


fibonacci(0)
fibonacci(1)
fibonacci(2)
fibonacci(3)
fibonacci(4)
fibonacci(7)
fibonacci(30)
