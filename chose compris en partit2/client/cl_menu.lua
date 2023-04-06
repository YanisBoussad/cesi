local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
}

function RageUI.Line()
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = RageUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                RenderRectangle(CurrentMenu.X + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 200)-150+8, CurrentMenu.Y + RageUI.ItemOffset + 15, 300, 3, 40,120,200,150)
                RageUI.ItemOffset = RageUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (RageUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = RageUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            RageUI.Options = RageUI.Options + 1
        end
    end
end

PoliceMenu = {
    AgentInService = 0,
    Matricule = "~r~Indéfini",
    NamePrename = "~r~Indéfini",
    ReasonArrestation = "~r~Indéfini",
    TimePrison = "~r~Indéfini",
    MatriculeKey = false,
    NamePrenameKey = false,
    ReasonArrestationKey = false,
    TimePrisonKey = false
}
CasierPolice = {}
local DragStatus = {}
DragStatus.isDragged = false
DragStatus.dragger = tonumber(draggerId)

OpenMenuPolice = function()
    local mainmenupolice = RageUI.CreateMenu("", "Voici les actions disponibles")
    local interactioncitoyenspolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")
    local interactionpersonspolice = RageUI.CreateSubMenu(mainmenupolice, "", "LSPD")
    local interactionvehiculepolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")
    local demanderenfortpolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")
    local interactionk9 = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")
    local miseenprisonpolice = RageUI.CreateSubMenu(mainmenupolice, "", "Voici les actions disponibles")

    RageUI.Visible(mainmenupolice, not RageUI.Visible(mainmenupolice))
    while mainmenupolice do 
        Wait(0)

        RageUI.IsVisible(mainmenupolice, function()
            
            RageUI.Checkbox("Prendre votre service", "Vous permet de commencer/arréter votre service", ServicePoliceCheck, {}, {
                onChecked = function()
                    TriggerServerEvent("ronflex:servicepolice", true)
                    ServicePoliceCheck = true 
                end,
                onUnChecked = function()
                    TriggerServerEvent("ronflex:servicepolice", false)
                    ServicePoliceCheck = false 
                end
            })

            if ServicePoliceCheck then 
                RageUI.Separator("Agent en service: ~r~"..PoliceMenu.AgentInService.."")
                RageUI.Button("→ Intéractions citoyens", "Vous permet d'intéragir avec les citoyens", {RightLabel = "→→→"}, true, {}, interactioncitoyenspolice)
                RageUI.Button("→ Intéractions Personnelle", "Vous permet d'intéragir avec les citoyens", {RightLabel = "→→→"}, true, {}, interactionpersonspolice)
                RageUI.Button("→ Intéractions véhicule", "Vous permet d'intéragir avec les véhicules", {RightLabel = "→→→"}, true, {}, interactionvehiculepolice)
                RageUI.Button("→ Codes radio", "Vous permet de faire des demandes de renfort", {RightLabel = "→→→"}, true, {}, demanderenfortpolice)
                RageUI.Button("→ Intéracion K-9", nil, {RightLabel = "→→→"}, true, {}, interactionk9)
                RageUI.Button("→ Mise en cellule", nil, {RightLabel = "→→→"}, true, {}, miseenprisonpolice)
            end
    
        end)

        RageUI.IsVisible(interactioncitoyenspolice, function()
            
            RageUI.Button("→ Fouiller un individu", "Vous permet de fouiller un citoyen", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        OpenFouillePolice(closestPlayer)

                    end
                end
            })

            RageUI.Button("→ Mettre dans un véhicule", "Vous permet de mettre l'individu dans un véhicule", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('police:putInVehicle', GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })

            RageUI.Button("→ Sortir du véhicule", "Vous permet de sortir un individu du véhicule véhicule", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('police:OutVehicle', GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end
            })

            RageUI.Button("→ Escorter", "Vous permet d'escorter le joueur", {RightLabel = "→→→"}, true, {
                onSelected = function() 
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('police:drag', GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                    end
                end,
            })

            RageUI.Button("→ Menotter/démenotter", nil, {RightLabel = "→→→"}, true, {
				onSelected = function() 
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        print('Sa marche')
					    TriggerServerEvent('krz_handcuff:handcuff', GetPlayerServerId(closestPlayer))
				else
					ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
				end
			end,
		})

            RageUI.Button("→ Mettre une amande", "Vous permet de mettre une facture", {RightLabel = "→→→"}, true, {
                onSelected = function() 
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        local string = KeyboardInput('Montant de la facture', ('Montant de la facture'), '', 999)
                        if string ~= "" then
                            Montant = tonumber(string)
                        end
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Amande Police', Montant)
                    else
                        ESX.ShowNotification('~r~Erreur ~w~~n~Il n\'y a aucun joueurs au alentours')
                    end
                end,
            })
        
        end, function()
        end)

        RageUI.IsVisible(interactionvehiculepolice, function()
            RageUI.Button('→ Crocheter Véhicule', nil, {RightLabel = "→→→"}, true, {

                onActive = function()
                    local vehicle   = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId(), false), false)
                    local VehiclePos = 	GetEntityCoords(vehicle)
                    DrawMarker(2, VehiclePos.x, VehiclePos.y, VehiclePos.z+1.8, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 255, 143, 0, 170, false, true, nil, true)
                end,

                onSelected = function() 
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    if DoesEntityExist(vehicle) then
                        local plyPed = PlayerPedId()
    
                        TaskStartScenarioInPlace(plyPed, 'WORLD_HUMAN_WELDING', 0, true)
                        Citizen.Wait(20000)
                        ClearPedTasksImmediately(plyPed)
    
                        SetVehicleDoorsLocked(vehicle, 1)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                        ESX.ShowAdvancedNotification('~r~~r~Police~s~', '~h~Information véhicule~s~', 'Véhicule ~g~dévérouillé~s~', 'CHAR_CARSITE', 1)
                    else
                        ESX.ShowAdvancedNotification('~r~~r~Police~s~', '~h~Information véhicule~s~', '~r~Aucun véhicule~s~ à proximité~s~', 'CHAR_CARSITE', 1)
                    end
                end,
            })

            RageUI.Button('→ Mettre en fourrière', nil, {RightLabel = "→→→"}, true, {
                onActive = function()
                    local vehicle   = ESX.Game.GetClosestVehicle(GetEntityCoords(PlayerPedId(), false), false)
                    local VehiclePos = 	GetEntityCoords(vehicle)
                    DrawMarker(2, VehiclePos.x, VehiclePos.y, VehiclePos.z+1.8, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 255, 143, 0, 170, false, true, nil, true)
                end,

                onSelected = function() 
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    local plyPed = PlayerPedId()

                    TaskStartScenarioInPlace(plyPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    
                    ClearPedTasks(plyPed)
                    Citizen.Wait(4000)
                    ESX.Game.DeleteVehicle(vehicle)
                    ClearPedTasks(plyPed) 
                    ESX.ShowAdvancedNotification('~r~~r~Police~s~', '~h~Information véhicule~s~', 'Le véhicule à été mis en fourrière', 'CHAR_CARSITE', 1)
                end
            })

                RageUI.Button("→ Rechercher une plaque", nil, {RightLabel = "→→→"}, true , {
                    onSelected = function()
                        local numplaque = KeyboardInput('', '','', 100)
                        local length = string.len(numplaque)
                        if not numplaque or length < 2 or length > 8 then
                            ESX.ShowNotification("Ce n'est ~q~pas~s~ un numéro enregistrement dans les fichier de ~q~police")
                        else
                            Rechercherplaquevoiture(numplaque)
                            RageUI.CloseAll()
                        end
                    end,})
        
        end, function()
        end)

        
        RageUI.IsVisible(demanderenfortpolice, function()

            RageUI.Separator("↓ Demande de renfort ↓")

            RageUI.Button("→ Petite demande", "Vous permet de faire une petite demande de renfort", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "petite")
                end
            })

            RageUI.Button("→ Importante demande", "Vous permet de faire une demande de renfort importante", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "important")
                end
            })

            RageUI.Button("→ Code 99", "Vous permet de faire une allerte d'urgence", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "rouge")
                end
            })

            RageUI.Separator("↓ Codes radio ↓")

            RageUI.Button("→ Pause de service", "Vous permet de faire une allerte de pause de service", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "pause")
                end
            })

            RageUI.Button("→ Controle en cours", "Vous permet de faire une allerte de controle ", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "control")
                end
            })

            RageUI.Button("→ Retour au commisariat", "Vous permet de faire une allerte de retour au PDP ", {RightLabel = "→→→"}, true, {
                onSelected = function()
                    TriggerServerEvent("ronflex:demandederenfort", "retrourpdp")
                end
            })

        end)


        RageUI.IsVisible(interactionk9, function()
            
            RageUI.Checkbox("→ Sortir/Rentrer le chien", nil, chienpolice, {}, {
                onChecked = function(index, items)
                    chienpolice = true
                    if not DoesEntityExist(policeDog) then
                    RequestModel('a_c_shepherd')
                    while not HasModelLoaded('a_c_shepherd') do Wait(0) end
                    policeDog = CreatePed(4, 'a_c_shepherd', GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.98), 0.0, true, false)
                    SetEntityAsMissionEntity(policeDog, true, true)
                    ESX.ShowNotification('~g~Chien Spawn')
                    end
                end,
                onUnChecked = function(index, items)
                    chienpolice = false
                    ESX.ShowNotification('~q~Chien Rentrer')
                    DeleteEntity(policeDog)
                end
            })
            
            
            RageUI.Button("→ Assis", nil, {RightLabel = "→→→"}, true , {
                onSelected = function()
                    if DoesEntityExist(policeDog) then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                            if IsEntityPlayingAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 3) then
                                ClearPedTasks(policeDog)
                            else
                                loadDict('rcmnigel1c')
                                TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
                                Wait(2000)
                                loadDict("creatures@rottweiler@amb@world_dog_sitting@base")
                                TaskPlayAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                            end
                        else
                            ESX.ShowNotification('~q~Le chien est trop loin de vous !')
                        end
                    else
                        ESX.ShowNotification('~q~Vous n\'avez pas de chien !')
                    end
                end
                })
            
                RageUI.Button("→ Dire d'attaquer", nil, {RightLabel = "→→→"}, true , {
                    onSelected = function()
                        if DoesEntityExist(policeDog) then
                            if not IsPedDeadOrDying(policeDog) then
                                if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                    local player, distance = ESX.Game.GetClosestPlayer()
                                    if distance ~= -1 then
                                        if distance <= 3.0 then
                                            local playerPed = GetPlayerPed(player)
                                            if not IsPedInCombat(policeDog, playerPed) then
                                                if not IsPedInAnyVehicle(playerPed, true) then
                                                    TaskCombatPed(policeDog, playerPed, 0, 16)
                                                end
                                            else
                                                ClearPedTasksImmediately(policeDog)
                                            end
                                        end
                                    else
                                        ESX.ShowNotification("~q~Probleme~s~: Aucuns joueurs proche")
                                    end
                                else
                                    ESX.ShowNotification('~q~Le chien est trop loin de vous !')
                                end
                            else
                                ESX.ShowNotification('Votre chien est mort !')
                            end
                        else
                            ESX.ShowNotification('~q~Vous n\'avez pas de chien')
                        end
                    end
                    })
            
                    RageUI.Button("→ Monter/sortir du véhicule", nil, {RightLabel = "→→→"}, true , {
                        onSelected = function()
                            if DoesEntityExist(policeDog) then
                                if not IsPedInAnyVehicle(policeDog, false) then
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog)) <= 10.0 then
                                        local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 7.5, 0, 70)
                                        print(vehicle)
                                        if DoesEntityExist(vehicle) then
                                            for i = 0, GetVehicleMaxNumberOfPassengers(vehicle) do
                                                if IsVehicleSeatFree(vehicle, i) then
                                                    TaskEnterVehicle(policeDog, vehicle, 15.0, i, 1.0, 1, 0)
                                                    break
                                                end
                                            end
                                        else
                                            ESX.ShowNotification('~q~vous n\'avez pas de véhicule !')
                                        end
                                    else
                                        ESX.ShowNotification('~q~Le chien est trop loin de vous !')
                                    end
                                else
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog)) <= 5.0 then
                                        TaskLeaveVehicle(policeDog, GetVehiclePedIsIn(policeDog, false), 0)
                                    else
                                        ESX.ShowNotification('~q~Le chien est trop loin de vous !')
                                    end
                                end
                            else
                                ESX.ShowNotification('~q~Vous n\'avez pas de chien !')
                            end
                        end
                        })
            
                        RageUI.Button("→ Suis-moi", nil, {RightLabel = "→→→"}, true , {
                            onSelected = function()
                                local playerPed = PlayerPedId()
                                if DoesEntityExist(policeDog) then
                                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                                        TaskGoToEntity(policeDog, playerPed, -1, 1.0, 10.0, 1073741824, 1)
                                    else
                                        ESX.ShowNotification('~q~Le chien est trop loin de vous !')
                                    end
                                else
                                    ESX.ShowNotification('~q~Vous n\'avez pas de chien !')
                                end
                            end
                            })
            
                        end)

        RageUI.IsVisible(miseenprisonpolice, function()

            RageUI.Button("→ Cellule 1", "Mettre en prison dans la cellule 1", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local verif, timer = CheckQuantity(KeyboardInput("Indiquer le temps de prison", "Indiquer le temps de prison", "", 20))
                    if verif then 
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance ~= -1 and distance <= 3.0 then
                            TriggerServerEvent('ronflex:miseencelule', GetPlayerServerId(player), timer, "1")
                        else
                            ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                        end
                    end
                    
                end
            })
      
            RageUI.Button("→ Cellule 2", "Mettre en prison dans la cellule 1", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local verif, timer = CheckQuantity(KeyboardInput("Indiquer le temps de prison", "Indiquer le temps de prison", "", 20))
                    if verif then 
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance ~= -1 and distance <= 3.0 then
                            TriggerServerEvent('ronflex:miseencelule', GetPlayerServerId(player), timer, "2")
                        else
                            ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                        end
                    end
                    
                end

            })

            RageUI.Button("→ Cellule 3", "Mettre en prison dans la cellule 1", {RightLabel = "→→→"}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                        PlayerMarker(closestPlayer)
                    end
                end, 
                onSelected = function()
                    local verif, timer = CheckQuantity(KeyboardInput("Indiquer le temps de prison", "Indiquer le temps de prison", "", 20))
                    if verif then 
                        local player, distance = ESX.Game.GetClosestPlayer()
                        if distance ~= -1 and distance <= 3.0 then
                            TriggerServerEvent('ronflex:miseencelule', GetPlayerServerId(player), timer, "3")
                        else
                            ESX.ShowNotification('~r~Aucun joueur~s~ à proximité')
                        end
                    end
                    
                end
            })

        end, function()
        end)
       
        RageUI.IsVisible(interactionpersonspolice, function()
            
            RageUI.Button("→ Activer/désactiver props editor", nil, {RightLabel = "→→→"}, true , {
                onSelected = function()
                    inPropsEditor = not inPropsEditor
                    StartPropsEditor()
                end
            })
            for k,v in pairs(cfg_police.props) do
                RageUI.Button(v.label, nil, {RightLabel = "→→→"}, true , {
                    onSelected = function()
                        TriggerEvent("core:PlaceObject", v.prop)
                    end
                })
            end
            RageUI.Line()
                RageUI.Checkbox("→ Sortir/Rentrer un Bouclier", nil, bouclier, {}, {
                    onChecked = function(index, items)
                        bouclier = true
                        EnableShield()
                    end,
                    onUnChecked = function(index, items)
                        bouclier = false
                        DisableShield()
                    end
                })
        end)
        
        if not RageUI.Visible(mainmenupolice) and
        not RageUI.Visible(interactioncitoyenspolice) and 
        not RageUI.Visible(interactionpersonspolice) and 
        not RageUI.Visible(interactionvehiculepolice) and
        not RageUI.Visible(interactionk9) and
        not RageUI.Visible(miseenprisonpolice) and 
        not RageUI.Visible(demanderenfortpolice) then 
            mainmenupolice = RMenu:DeleteType('mainmenupolice')
        end
    end
end


RegisterNetEvent("ronflex:demandederenfort", function(type, coords)
    if type == "petite" then
        PlaySoundFrontend(-1,"Lose_1st", "GTAO_Magnate_Boss_Modes_Soundset", false); 
        local blipId = AddBlipForCoord(coords)
        SetBlipSprite(blipId, 161)
        SetBlipScale(blipId, 0.7)
        SetBlipColour(blipId, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('~g~Demande renfort')
        EndTextCommandSetBlipName(blipId)
        Wait(80 * 1000)
        RemoveBlip(blipId)
    elseif type == 'important' then 
        local blipId = AddBlipForCoord(coords)
        SetBlipSprite(blipId, 161)
        SetBlipScale(blipId, 0.7)
        SetBlipColour(blipId, 47)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('~o~Demande renfort')
        EndTextCommandSetBlipName(blipId)
        Wait(80 * 1000)
        RemoveBlip(blipId)
    elseif type == 'rouge' then 
        PlaySoundFrontend(-1, "police_notification", "DLC_AS_VNT_Sounds", true);
        local blipId = AddBlipForCoord(coords)
        SetBlipSprite(blipId, 161)
        SetBlipScale(blipId, 0.7)
        SetBlipColour(blipId, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('~r~Demande renfort')
        EndTextCommandSetBlipName(blipId)
        Wait(80 * 1000)
        RemoveBlip(blipId)
    end
end)

Keys.Register("F6", "Menu_Police", "Menu Intéraction police", function()
    if ESX.PlayerData.job.name == "police" then 
        OpenMenuPolice()
    end
end)


RegisterNetEvent("ronflex:recieveagentpolice")
AddEventHandler("ronflex:recieveagentpolice", function(count)
    PoliceMenu.AgentInService = count
end)


RegisterNetEvent('police:OutVehicle')
AddEventHandler('police:OutVehicle', function()
	local plyPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(plyPed) then
		return
	end

	DetachEntity(plyPed, true, false)
	local vehicle = GetVehiclePedIsIn(plyPed, false)
	TaskLeaveVehicle(plyPed, vehicle, 16)
end)


RegisterNetEvent('police:putInVehicle')
AddEventHandler('police:putInVehicle', function()
	local plyPed = PlayerPedId()
	local coords = GetEntityCoords(plyPed, false)

    if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				DetachEntity(plyPed, true, false)
				TaskWarpPedIntoVehicle(plyPed, vehicle, freeSeat)
			end
		end
	end
end)


RegisterNetEvent('police:drag')
AddEventHandler('police:drag', function(draggerId)
    DragStatus.isDragged = not DragStatus.isDragged
    DragStatus.dragger = tonumber(draggerId)

    if not DragStatus.isDragged then
        DetachEntity(PlayerPedId(), true, false)
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local plyPed = PlayerPedId()

        if DragStatus.isDragged then
            local target = GetPlayerFromServerId(DragStatus.dragger)

            if target ~= PlayerId() and target > 0 then
                local targetPed = GetPlayerPed(target)

                if not IsPedSittingInAnyVehicle(targetPed) then
                    AttachEntityToEntity(plyPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                else
                    DragStatus.isDragged = false
                    DetachEntity(plyPed, true, false)
                end
            else
                Wait(500)
            end
        else
            Wait(500)
        end
    end
end)

RegisterNetEvent('krz_handcuff:handcuff')
AddEventHandler('krz_handcuff:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = PlayerPedId()

  Citizen.CreateThread(function()

    if IsHandcuffed then

        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do
            Citizen.Wait(100)
        end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      DisableControlAction(2, 37, true)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
      DisableControlAction(0, 37, true) -- Select Weapon
      DisableControlAction(0, 47, true)  -- Disable weapon
      

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

OpenFouillePolice = function(closestPlayer)
    local mainfouille = RageUI.CreateMenu("Fouille", "Voici l'inventaire du joueur")

    RageUI.Visible(mainfouille, not RageUI.Visible(mainfouille))
    InventoryLoad = false 

    ESX.TriggerServerCallback("ronfex:fouillepolicecb", function(data)
        weaponplayer = data.weapon 
        inventoryplayer = data.inventory
        InventoryLoad = true 
    end, GetPlayerServerId(closestPlayer))    

    while mainfouille do
        Wait(0)

        RageUI.IsVisible(mainfouille, function()

            if InventoryLoad == false then 
                RageUI.Separator("")
                RageUI.Separator("~r~Récupération des données")
                RageUI.Separator("")
            else
                RageUI.Separator("↓ Items ↓")
                for k, v in pairs(inventoryplayer) do 
                    if v.count > 0 then 
                        RageUI.Button("→ "..v.label.." ["..v.count.."]", nil, {RightLabel = "~r~Récupérer"}, true, {
                            onSelected = function()
                                local verif, count = CheckQuantity(KeyboardInput("Combien voulez vous en prendre", "Combien voulez vous en prendre", "", 20))
                                if verif then 
                                    TriggerServerEvent("ronflex:confiscateitem", count, v.name, GetPlayerServerId(closestPlayer), "item")
                                    Wait(50)
                                    ESX.TriggerServerCallback("ronfex:fouillepolicecb", function(data)
                                        weaponplayer = data.weapon 
                                        inventoryplayer = data.inventory
                                        InventoryLoad = true 
                                    end, GetPlayerServerId(closestPlayer))    
                                end
                            end
                        })
                    end
   
                end

                RageUI.Separator("↓ Armes ↓")
                for k, v in pairs(weaponplayer) do
                    RageUI.Button("→ "..tostring(v.label).."", nil, {RightLabel = "~r~Récupérer"}, false, {
                        onSelected = function()
                            TriggerServerEvent("ronflex:confiscateitem", nil, v.name, GetPlayerServerId(closestPlayer), "weapon", v.label)
                            Wait(50)
                            ESX.TriggerServerCallback("ronfex:fouillepolicecb", function(data)
                                weaponplayer = data.weapon 
                                inventoryplayer = data.inventory
                                InventoryLoad = true 
                            end, GetPlayerServerId(closestPlayer))   
                        end
                    })
                end
            
            end
        end)

        if not RageUI.Visible(mainfouille) then 
            mainfouille = RMenu:DeleteType('mainfouille')
            OpenMenuPolice()
        end

    end
end

function Rechercherplaquevoiture(plaquerechercher)
    local PlaqueMenu = RageUI.CreateMenu("", "Informations")
    ESX.TriggerServerCallback('police:getVehicleInfos', function(retrivedInfo)
    RageUI.Visible(PlaqueMenu, not RageUI.Visible(PlaqueMenu))
        while PlaqueMenu do
            Citizen.Wait(0)
					RageUI.IsVisible(PlaqueMenu,function()
                            RageUI.Button("Numéro de plaque : ", nil, {RightLabel = retrivedInfo.plate}, true, {
                                	onSelected = function()
                                    end
                                })
						
                            if not retrivedInfo.owner then
                                RageUI.Button("Propriétaire : ", nil, {RightLabel = "Inconnu"}, true, {
                                    	onSelected = function()
                                		end
                                    })
                            else
                                RageUI.Button("Propriétaire : ", nil, {RightLabel = retrivedInfo.owner}, true, {
                                    	onSelected = function()
										end
                                    })

								local hashvoiture = retrivedInfo.vehicle.model
								local nomvoituremodele = GetDisplayNameFromVehicleModel(hashvoiture)
								local nomvoituretexte  = GetLabelText(nomvoituremodele)

                                RageUI.Button("Modèle du véhicule : ", nil, {RightLabel = nomvoituretexte}, true, {
                                    	onSelected = function()
										end
                                    })
                            end
                end, function()
                end)
            if not RageUI.Visible(PlaqueMenu) then
            PlaqueMenu = RMenu:DeleteType("plaque d'immatriculation", true)
        end
    end
end, plaquerechercher)
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

-- ANIM
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = "prop_ballistic_shield"

function EnableShield()
    shieldActive = true
    local ped = GetPlayerPed(-1)
    local pedPos = GetEntityCoords(ped, false)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(250)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(250)
    end

    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))
    SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = GetPlayerPed(-1)
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))
    SetEnableHandcuffs(ped, false)
    shieldActive = false
end

Citizen.CreateThread(function()
    while true do
        if shieldActive then
            local ped = GetPlayerPed(-1)
            if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(100)
                end
            
                TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
        end
        Citizen.Wait(500)
    end
end)