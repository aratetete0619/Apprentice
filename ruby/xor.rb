def xor(x, y)
  if x == true && y == true
    puts false
  elsif x == false && y == false
    puts false
  else
    puts true
  end
end

xor(true, true)
xor(true, false)
xor(false, true)
xor(false, false)
