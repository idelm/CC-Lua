-- Function to check players within a specific range
function checkPlayersInRange()
    -- Define the range to check (e.g., 10 blocks)
    local range = 10

    -- Get a list of players within the range
    local players = commands.exec("execute as @a[distance=.."..range.."] if entity @s[nbt={Health:0.0}] run member @s addrole 611b8a85-c74c-49e0-9100-b578ff30e30d")

    -- If any players are found within the range
    if players then
        for i, player in ipairs(players) do
            -- Run the addrole command for each detected player
            commands.exec("member "..player.." addrole 611b8a85-c74c-49e0-9100-b578ff30e30d")
        end
    end
end

-- Main loop to continuously check for player deaths
while true do
    checkPlayersInRange()
    os.sleep(1)  -- Wait for 1 second before checking again
end
