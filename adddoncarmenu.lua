local menu = nil
local categories = {
    "Super",
    "Sports",
    "Muscle",
    "Off-Road",
    "SUV",
    "Police"
}
local vehicles = {
    ["Super"] = {
        {model = "adder", name = "Charger"},
        {model = "t20", name = "McLaren P1"},
        {model = "zentorno", name = "Lamborghini Sesto Elemento"},
    },
    ["Sports"] = {
        {model = "comet2", name = "Porsche 911"},
        {model = "futo", name = "Toyota AE86"},
        {model = "jester", name = "Toyota Supra"},
    },
    ["Muscle"] = {
        {model = "dominator", name = "Ford Mustang"},
        {model = "gauntlet", name = "Dodge Challenger"},
        {model = "sabregt", name = "Chevrolet Camaro"},
    },
    ["Off-Road"] = {
        {model = "bifta", name = "Buggy"},
        {model = "blazer", name = "ATV"},
        {model = "sandking", name = "Monster Truck"},
    },
    ["SUV"] = {
        {model = "baller", name = "Range Rover"},
        {model = "granger", name = "Chevrolet Suburban"},
        {model = "huntley", name = "Bentley Bentayga"},
    },
}
------------------------------------
--[[
NEED SUPPORT? 
JOIN https://discord.gg/W4ARMwxBbE
https://discord.gg/W4ARMwxBbE
https://discord.gg/W4ARMwxBbE
]]--
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
-- DO NOT EDIT BELOW THIS
------------------------------------
local selectedCategory = nil
local selectedVehicle = nil

function InitMenu()
    menu = MenuV:CreateMenu("Addon Car Menu", "Select a category", "right", 0, 255, 0, "size-125", "default", "menuv", generate_random_letters())
    for i = 1,#categories do
        local categoryName = categories[i]
        local categoryButton = menu:AddButton({icon = "🚗", label = categoryName, value = categoryName, description = "Spawn a vehicle from this category"})
        categoryButton:On("select", function(item)
            selectedCategory = item.Value
            OpenSubmenu()
        end)
    end
end

function OpenSubmenu()
    if selectedCategory then
        local submenu = MenuV:CreateMenu(false, "Addon Car Menu - " .. selectedCategory, "right", 0, 255, 0, "size-125", "default", "menuv", generate_random_letters())
        for i = 1,#vehicles[selectedCategory] do
            local vehicleModel = vehicles[selectedCategory][i].model
            local vehicleName = vehicles[selectedCategory][i].name
            local vehicleButton = submenu:AddButton({icon = "🚗", label = vehicleName, value = vehicleModel, description = "Spawn this vehicle"})
            vehicleButton:On("select", function(item)
                selectedVehicle = item.Value
                SpawnVehicle()
            end)
        end
        submenu:Open()
    end
end

    function SpawnVehicle()
        if selectedVehicle then
            RequestModel(selectedVehicle)
            while not HasModelLoaded(selectedVehicle) do
                Wait(0)
            end
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local playerHeading = GetEntityHeading(playerPed)
            local vehicle = CreateVehicle(selectedVehicle, playerCoords, playerHeading, true, false)
            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
            SetVehicleNumberPlateText(vehicle, "ADDON")
            SetEntityAsMissionEntity(vehicle, true, true)
            SetModelAsNoLongerNeeded(selectedVehicle)
        end
    end

    RegisterCommand('car', function()
        InitMenu()
Wait(1000)
    menu:Open()
    end, false)

    function generate_random_letters()
        local letters = "abcdefghijklmnopqrstuvwxyz"
        local result = ""
        for i = 1, 10 do
          local random_index = math.random(1, #letters)
          result = result .. string.sub(letters, random_index, random_index)
        end
        return result
      end
