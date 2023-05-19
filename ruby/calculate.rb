def calculate(num1, num2, operator)
  raise ZeroDivisionError, 'ゼロによる割り算は許可されていません' if num1 == 0 || num2 == 0
  raise ArgumentError, '引数は整数である必要があります。' unless num1.to_s =~ /^-?\d+$/ && num2.to_s =~ /^-?\d+$/

  operator = %r{^[+\-/*]$} =~ operator ? operator : raise(ArgumentError, '演算子には +、-、*、/ のいずれかを使用してください')
  puts eval("#{num1} #{operator} #{num2}")
end

puts '1番目の整数を入力してください:'
num1 = gets.chomp

puts '2番目の整数を入力してください:'
num2 = gets.chomp

puts '演算子(+, -, *, /)を入力してください:'
operator = gets.chomp

begin
  result = calculate(num1, num2, operator)
  puts result
rescue ZeroDivisionError => e
  puts  e.message
rescue ArgumentError => e
  puts e.message
end
