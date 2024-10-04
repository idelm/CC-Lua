for i = 1, length do
  for j = 1, width do
    turtle.digDown()
    turtle.forward()
  end
  turtle.turnRight()
  turtle.forward()
  turtle.turnRight()
  for j = 1, width do
    turtle.digDown()
    turtle.forward()
  end
  turtle.turnLeft()
  turtle.forward()
  turtle.turnLeft()
end
