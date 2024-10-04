-- Set the dimensions of each quadrant
local length = 23  -- Number of blocks in the x direction
local width = 37   -- Number of blocks in the z direction
local height = 29  -- Number of blocks in the y direction

-- Define the chest's position (relative to turtle's start position or global coords)
local chestX, chestY, chestZ = 410, 64, -470 -- Adjust these coordinates to where the chest is located

-- Calculate fuel requirements based on movements
-- Each block movement uses 1 unit of fuel, and returning to the chest also uses fuel
local function calculateFuelRequired()
    -- Total number of block movements in the working area
    local movementsPerLayer = (length * width) + (length + width - 2) * height
    -- Number of layers to clear
    local totalMovements = movementsPerLayer * height
    -- Estimate for return trips to the chest
    local estimatedChestTrips = math.floor(totalMovements / 16) -- 16 slots in inventory, each move could require a trip back
    local fuelForChestTrips = estimatedChestTrips * (math.abs(chestX) + math.abs(chestY) + math.abs(chestZ)) * 2 -- round trip
    -- Total fuel required
    return totalMovements + fuelForChestTrips
end

-- Function to check if the turtle has enough fuel
function checkFuel()
    local currentFuel = turtle.getFuelLevel()
    local requiredFuel = calculateFuelRequired()

    print("Fuel required: " .. requiredFuel)
    print("Current fuel: " .. currentFuel)

    if currentFuel == "unlimited" or currentFuel >= requiredFuel then
        print("Fuel is sufficient. Starting work.")
        return true
    else
        print("Insufficient fuel! Fuel required: " .. requiredFuel .. ", Current fuel: " .. currentFuel)
        return false
    end
end

-- Function to check if the turtle's inventory is full
function isInventoryFull()
    for i = 1, 16 do
        if turtle.getItemCount(i) == 0 then
            return false  -- Inventory is not full
        end
    end
    return true  -- Inventory is full
end

-- Function to move the turtle to a specific location (simple version assuming direct path)
function goTo(x, y, z)
    local currX, currY, currZ = gps.locate()  -- Get current position with GPS
    
    -- Move vertically to the target Y level
    while currY < y do
        turtle.up()
        currY = currY + 1
    end
    while currY > y do
        turtle.down()
        currY = currY - 1
    end

    -- Move along the X axis
    while currX < x do
        turtle.forward()
        currX = currX + 1
    end
    while currX > x do
        turtle.back()
        currX = currX - 1
    end

    -- Move along the Z axis
    while currZ < z do
        turtle.forward()
        currZ = currZ + 1
    end
    while currZ > z do
        turtle.back()
        currZ = currZ - 1
    end
end

-- Function to return to the chest, dump items, and go back to work
function returnToChestAndDump(currX, currY, currZ)
    -- Move to the chest's location
    goTo(chestX, chestY, chestZ)

    -- Dump all items into the chest
    for i = 1, 16 do
        turtle.select(i)
        turtle.drop()
    end

    -- Return to the saved position and resume work
    goTo(currX, currY, currZ)
end

-- Main script execution
if checkFuel() then
    -- Main loop to clear the area if fuel check is successful
    for h = 1, height do
        for i = 1, length do
            for j = 1, width do
                turtle.digDown()   -- Digs the block below the turtle

                -- Check if the inventory is full after each dig
                if isInventoryFull() then
                    local currX, currY, currZ = gps.locate() -- Get current position before heading to chest
                    returnToChestAndDump(currX, currY, currZ) -- Go to chest and return
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
end
