-- Start of the startup script

-- Check and display the current fuel level
local fuelLevel = turtle.getFuelLevel()

-- Display the fuel level to the user
if fuelLevel == "unlimited" then
    print("Fuel level: Unlimited")
else
    print("Fuel level: " .. fuelLevel)
end

-- End of the startup script