-- Define the number of blocks to mine
local blocksToMine = 100  -- Change this number to the desired number of blocks
local returnPosition = 0  -- Keeps track of how many blocks the Turtle has moved forward

-- Check if the turtle has enough fuel
if turtle.getFuelLevel() == 0 then
    print("Out of fuel!")
    return
end

-- Function to deposit all items in the chest
function depositItems()
    turtle.turnLeft()
    turtle.turnLeft()  -- Turn around to face the chest

    for slot = 1, 16 do
        turtle.select(slot)
        turtle.drop()
    end

    turtle.turnLeft()
    turtle.turnLeft()  -- Turn back around to resume mining
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

-- Loop to mine the specified number of blocks
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

    returnPosition = returnPosition + 1  -- Keep track of the number of blocks moved forward

    -- Check if the inventory is full
    if turtle.getItemCount(16) > 0 then
        print("Inventory full, returning to deposit items...")

        -- Return to the starting point to deposit items
        returnToStart()
        depositItems()

        -- Go back to the position where mining was stopped
        goBackToPosition()
    end
end

-- End of the script
print("Mining complete!")