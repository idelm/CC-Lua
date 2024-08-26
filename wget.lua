-- Configuration
local range = 10  -- Range to monitor around the computer. Do ..10 for range within 10 block, do 10.. for range outside.
local roleID = "611b8a85-c74c-49e0-9100-b578ff30e30d"  -- The role ID to manage

-- Function to remove role for players within the range
function removeRoleInRange()
    commands.exec("execute as @a[distance=.."..range.."] run member @s removerole " .. roleID)
end

-- Function to add role for players outside the range
function addRoleOutsideRange()
    commands.exec("execute as @a[distance="..(range+1).."..] run member @s addrole " .. roleID)
end

-- Function to add role when a player dies within the range
function addRoleOnDeathInRange()
    commands.exec("execute as @a[distance=.."..range.."] if entity @s[nbt={Health:0.0}] run member @s addrole " .. roleID)
end

-- Main loop to continuously manage roles
while true do
    removeRoleInRange()
    addRoleOutsideRange()
    addRoleOnDeathInRange()
    os.sleep(1)  -- Wait for 1 second before checking again
end
