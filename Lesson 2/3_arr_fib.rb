array = []
x = 0
y = 1
while x < 100
  array << x
  x += y
  array << y if y < 100
  y += x  
end
puts array
