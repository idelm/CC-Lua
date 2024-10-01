-- Function to mine the 8x8x8 area
function mineArea(width, length, height)
    for h = 1, height do
        for l = 1, length do
            for w = 1, width - 1 do
                turtle.dig()
                turtle.forward()
            end
            if l < length then
                if l % 2 == 1 then
                    turtle.turnRight()
                    turtle.dig()
                    turtle.forward()
                    turtle.turnRight()
                else
                    turtle.turnLeft()
                    turtle.dig()
                    turtle.forward()
                    turtle.turnLeft()
                end
            end
        end
        if h < height then
            if length % 2 == 1 then
                turtle.turnRight()
            else
                turtle.turnLeft()
            end
            turtle.digDown()
            turtle.down()
            if length % 2 == 1 then
                turtle.turnRight()
            else
                turtle.turnLeft()
            end
        end
    end
end

-- Call the function with an 8x8x8 area
mineArea(8, 8, 8)