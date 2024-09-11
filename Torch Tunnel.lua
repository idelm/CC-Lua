-- Define the number of blocks to mine
local blocksToMine = 100  -- Change this number to the desired number of blocks
local returnPosition = 0   -- Keeps track of how many blocks the Turtle has moved forward

-- Function to check and handle fuel level
function checkFuel()
    local fuelLevel = turtle.getFuelLevel()

    -- If fuel is below 100, try to refuel
    if fuelLevel < 100 then
        turtle.select(1)  -- Select slot 1 to refuel (assumes fuel is in slot 1)
        turtle.refuel()
        fuelLevel = turtle.getFuelLevel()  -- Update fuel level after refueling

        if fuelLevel == 0 then
            print("No fuel.")
            return false
        elseif fuelLevel < 50 then
            print("Low fuel.")
        end
    end

    return true
end

-- Function to deposit all items except torches
function depositItems()
    turtle.turnLeft()
    turtle.turnLeft()  -- Turn around to face the chest

    for slot = 1, 14 do
        turtle.select(slot)
        turtle.drop()
    end

    turtle.turnLeft()
    turtle.turnLeft()  -- Turn back around to resume mining
end

-- Function to place a torch
function placeTorch()
    -- First, try to place from slot 16
    turtle.select(16)
    if turtle.getItemCount(16) > 0 then
        turtle.placeDown()
    else
        -- If slot 16 is empty, try slot 15
        turtle.select(15)
        if turtle.getItemCount(15) > 0 then
            turtle.placeDown()
        else
            print("No torches left to place!")
        end
    end
end

-- Function to return to the starting position
function returnToStart()
    for i = 1, returnPosition do
        turtle.back()
    end
end

-- Function to go back to the current position
function goBackToPosition()
    for i = 1, returnPosition do
        turtle.forward()
    end
end

-- Start of the mining process
if not checkFuel() then
    return
end

-- Main loop to mine the specified number of blocks
for i = 1, blocksToMine do
    -- Check if there is a block in front and dig if there is
    while turtle.detect() do
        turtle.dig()
    end

    -- Attempt to move forward
    if not turtle.forward() then
        print("Movement blocked, cannot proceed!")
        return
    end

   
