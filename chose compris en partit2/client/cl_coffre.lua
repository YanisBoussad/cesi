TriggerEvent('modo:LeyRider', function(obj) ESX = obj end)


local PlayerInventory, GangInventoryItem, GangInventoryWeapon, PlayerWeapon = {}, {}, {}, {}

local mainMenu = RageUI.CreateMenu("", "Quel actions voulez vous faire")
local PutMenu = RageUI.CreateSubMenu(mainMenu,"", "Choisissez l'objet à déposer")
local GetMenu = RageUI.CreateSubMenu(mainMenu,"", "Choisissez l'objet à prendre")


local open = false

mainMenu:DisplayGlare(false)
mainMenu.Closed = function()
    open = false
end

all_items = {}

    
function ChestPolice() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Prendre un objet", " ", {RightLabel = "→"}, true, {onSelected = function()
                getStockPolice()
            end},GetMenu);

            RageUI.Button("Déposer un objet", " ", {RightLabel = "→"}, true, {onSelected = function()
                getInventoryPolice()
            end},PutMenu);

            

        end)

        RageUI.IsVisible(GetMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, " ", {RightLabel = "~b~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput('', '','', 100)
                    count = tonumber(count)
                    if count <= v.nb then
                        TriggerServerEvent("police:takeStockItems",v.item, count)
                    else
                        ESX.ShowNotification("~b~Vous n'en avez pas assez sur vous")
                    end
                    getStockPolice()
                end});
            end

        end)

        RageUI.IsVisible(PutMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, " ", {RightLabel = "~b~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput('', '','', 100)
                    count = tonumber(count)
                    TriggerServerEvent("police:putStockItems",v.item, count)
                    getInventoryPolice()
                end});
            end
        end)



        Wait(0)
    end
 end)
 end
 end



function getInventoryPolice()
    ESX.TriggerServerCallback('police:playerinventory', function(inventory)               
                
        all_items = inventory
        
    end)
end

function getStockPolice()
    ESX.TriggerServerCallback('police:getStockItems', function(inventory)               
                
        all_items = inventory

    end)
end


Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				for k in pairs(cfg_police.Position.Coffre) do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local pos = cfg_police.Position.Coffre
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

				if dist <= cfg_police.MarkerDistance then
					wait = 0
					DrawMarker(cfg_police.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 69, 112, 246, 150, false, true, 2, true, false, false, false)  
				end

				if dist <= 2.0 then
					wait = 0
					Visual.Subtitle(cfg_police.TextCoffre, 1)
					if IsControlJustPressed(1,51) then
						ChestPolice()
					end
				end
			end
		end
    Citizen.Wait(wait)
    end
end)