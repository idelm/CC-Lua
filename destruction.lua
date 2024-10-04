-- Set the dimensions of each quadrant
local length = 23  -- Number of blocks in the x direction
local width = 37   -- Number of blocks in the z direction
local height = 29  -- Number of blocks in the y direction

local chestX, chestY, chestZ = 0, 0, 0 -- Set your chest's coordinates relative to the starting point
local startX, startY, startZ = 0, 0, 0 -- Starting position for the turtle

-- Function to check if the turtle's inventory is full
function isInventoryFull()
    for i = 1, 16 do
        if turtle.getItemCount(i) == 0 then
            return false  -- Inventory is not full
        end
    end
    return true  -- Inventory is full
end

-- Function to return to the chest, dump items, and go back to work
function returnToChestAndDump()
    -- Save current position and direction (assumes turtle starts at chest and moves systematically)
    local currentX, currentY, currentZ = gps.locate()  -- Get turtle's current coordinates
    turtle.goTo(chestX, chestY, chestZ) -- Go back to the chest (you may need a custom goTo function or manually program movement)
    
    -- Dump all items into the chest
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop()
    end
    
    -- Return to the saved position and resume work
    turtle.goTo(currentX, currentY, currentZ)
end

-- Main loop to clear the area
for h = 1, height do
    for i = 1, length do
        for j = 1, width do
            turtle.digDown()  -- Digs the block below the turtle

            -- Check if the inventory is full after each dig
            if isInventoryFull() then
                returnToChestAndDump()  -- Return to the chest and dump items
            end

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
