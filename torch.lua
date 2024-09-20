-- Place Torches Every 9 Blocks
-- This script makes the turtle move forward and place torches every 9 blocks.

-- Variables
local stepCount = 0   -- Counter to track the number of blocks moved

-- Function to select a slot with torches
function selectTorchSlot()
    for slot = 1, 16 do
        turtle.select(slot)
        local item = turtle.getItemDetail()
        if item and item.name == "minecraft:torch" then
            return true  -- Slot with torches found
        end
    end
    return false  -- No torches found
end

-- Function to place a torch if on the 9th step
function placeTorchIfNeeded()
    if stepCount % 9 == 0 then
        if selectTorchSlot() then
            turtle.placeDown()  -- Place torch on the ground
        else
            print("Out of torches!")
            os.sleep(2)  -- Wait for 2 seconds before continuing to check again
        end
    end
end

-- Main Loop
while true do
    -- Move forward
    if turtle.forward() then
        stepCount = stepCount + 1
        placeTorchIfNeeded()
    else
        print("Movement blocked!")
        break
    end
end