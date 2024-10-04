-- Function to check if GPS is available
function checkGPS()
    local x, y, z = gps.locate(5) -- Tries to locate with a 5-second timeout
    if x and y and z then
        print("GPS is available. Position: X=" .. x .. " Y=" .. y .. " Z=" .. z)
        return true
    else
        print("GPS is unavailable! Please ensure GPS towers are set up.")
        return false
    end
end
