-- Set the dimensions of each quadrant
local length = 23  -- Number of blocks in the x direction
local width = 37   -- Number of blocks in the z direction
local height = 29  -- Number of blocks in the y direction

-- Main loop to clear the area
for h = 1, height do
  for i = 1, length do
    for j = 1, width do
      turtle.digDown()   -- Digs the block below the turtle
      if j < width then
        turtle.forward() -- Move forward to next block
      end
    end
    
    -- Turn around at the end of each row
    if i < length then
      if i % 2 == 1 then
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
      else
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
      end
    end
  end

  -- Move up to the next layer once the entire row is cleared
  if h < height then
    turtle.up()
  end
end
