Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('modo:LeyRider', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('', 'Interaction')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  FreezeEntityPosition(PlayerPedId(), false)
  open = false
end

function OpenArmuriePolice()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 
              
              RageUI.Separator("↓ ~g~   Déposer ses armes  ~s~↓")

              RageUI.Button("~b~Déposer ses armes", nil, {RightLabel = "→→"}, true , {
                onSelected = function() 
                  RemoveAllPedWeapons(PlayerPedId(), true)
                  ESX.ShowNotification("Vous avez ~b~déposé ~s~toutes vos ~b~armes ~s~!")
                  end
                })

                RageUI.Separator("↓ Récupèrer un équipement ↓")
                --if servicepolice then
                for k,v in pairs(cfg_police.armurie) do
                    RageUI.Button("Équipement ~b~"..v.grade, nil, { RightLabel = "→→" }, ESX.PlayerData.job.grade >= v.minimum_grade, {
                        onSelected = function()
                            local pPed = GetPlayerPed(-1)
                            for k,v in pairs(v.weapons) do
                              TriggerServerEvent('armurie:giveweapon', v)  
                              --GiveWeaponToPed(pPed, GetHashKey(v), 255, 1, 0)
                            end
                            ESX.ShowNotification("Armes de service récupérer.")
                        end,
                    })
                end
              --else
                --RageUI.Separator("~b~Vous n\'êtes pas en service")
             -- end

                end)
                Wait(0)
               end
            end)
         end
      end
      

----OUVRIR LE MENU------------

local position = {
	{x = 479.0859, y = -996.757, z = 29.71}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 5.0 then
            wait = 0
            DrawMarker(6, 479.0859, -996.757,  29.71, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 69, 112, 246, 150, false, true, 2, true, false, false, false)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour intéragir", 1) 
                if IsControlJustPressed(1,51) then
                  FreezeEntityPosition(PlayerPedId(), true)
                    OpenArmuriePolice()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)









