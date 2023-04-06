TriggerEvent('modo:LeyRider', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'police', 'alerte police', true, true)

TriggerEvent('esx_society:registerSociety', 'police', 'police', 'society_police', 'society_police', 'society_police', {type = 'public'})


-- Coffre

ESX.RegisterServerCallback('police:playerinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end

	cb(all_items)

	
end)


ESX.RegisterServerCallback('police:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('police:putStockItems')
AddEventHandler('police:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	if xPlayer.job.name == 'police' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
			if item_in_inventory >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Dépot\n~s~- ~g~Item ~s~: "..itemName.."\n~s~- ~o~Quantitée ~s~: "..count.."")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous n'en avez pas assez sur vous")
			end
		end)
	end
end)

RegisterServerEvent('police:takeStockItems')
AddEventHandler('police:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
				xPlayer.addInventoryItem(itemName, count)
				inventory.removeItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Retrait\n~s~- ~g~Item ~s~: "..itemName.."\n~s~- ~o~Quantitée ~s~: "..count.."")
		end)
	end
end)




-- Boss

RegisterServerEvent('police:withdrawMoney')
AddEventHandler('police:withdrawMoney', function(society, amount, money_soc)
	local xPlayer = ESX.GetPlayerFromId(source)
	local src = source
  
	if xPlayer.job.name == 'police' then
		TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
		if account.money >= tonumber(amount) then
			xPlayer.addMoney(amount)
			account.removeMoney(amount)
			TriggerClientEvent("esx:showNotification", src, "- ~o~Retiré \n~s~- ~g~Somme : "..amount.."$")
		else
			TriggerClientEvent("esx:showNotification", src, "- ~g~L'entreprise \n~s~- ~g~Pas assez d'argent")
		end
		end)
	end
end)

RegisterServerEvent('police:depositMoney')
AddEventHandler('police:depositMoney', function(society, amount)

	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	local src = source
  
	if xPlayer.job.name == 'police' then
		TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
		if money >= tonumber(amount) then
			xPlayer.removeAccountMoney('cash', amount)
			account.addMoney(amount)
			TriggerClientEvent("esx:showNotification", src, "- ~o~Déposé \n~s~- ~g~Somme : "..amount.."$")
		else
			TriggerClientEvent("esx:showNotification", src, "- ~g~Erreur \n~s~- ~g~Pas assez d'argent")
		end
		end)
	end
	
end)

ESX.RegisterServerCallback('police:getSocietyMoney', function(source, cb, soc)
	local money = nil
		MySQL.Async.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @society ', {
			['@society'] = soc,
		}, function(data)
			for _,v in pairs(data) do
				money = v.money
			end
			cb(money)
		end)
end)

--- Prise de service

function sendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "AstaLife police",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(cfg_policeWebhookRendezVouspolice, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('police:prisedeservice')
AddEventHandler('police:prisedeservice', function()
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	sendToDiscordWithSpecialURL("Prise de service",xPlayer.getName().." à prise son service", 16744192, cfg_policeWebhookRendezVouspolice)
end)

RegisterNetEvent('police:quitteleservice')
AddEventHandler('police:quitteleservice', function()
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	sendToDiscordWithSpecialURL("Fin de service",xPlayer.getName().." à quitter son service", 16744192, cfg_policeWebhookRendezVouspolice)
end)

--- Accueil

local function sendToDiscordWithSpecialURL(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "AstaLife police",
	            ["icon_url"] = nil,
	            },
	        }
	    }
	PerformHttpRequest(cfg_policeWebhookRendezVousPolice, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("Rdv:PoliceMotif")
AddEventHandler("Rdv:PoliceMotif", function(nomprenom, numero, heurerdv, rdvmotif)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    --local ident = xPlayer.getIdentifier()
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end

	--if ident == 'steam:11' then--Special character in username just crash the server
	--else 
		sendToDiscordWithSpecialURL(16744192, "Nouveau Rendez-Vous\n\n```Nom : "..nomprenom.."\n\nNuméro de Téléphone: "..numero.."\n\nHeure du Rendez Vous : " ..heurerdv.."\n\nMotif du Rendez-vous : " ..rdvmotif.. "\n\n```Date : " .. date.day .. "." .. date.month .. "." .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min " .. date.sec)
	--end
end)

RegisterServerEvent('Appel:police')
AddEventHandler('Appel:police', function()
    
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Police', '~g~Accueil', 'Un policier est appelé à l\'accueil !', 'CHAR_ABIGAIL', 8)
        end
    end
end)

-- Infos Police
RegisterServerEvent('police:PriseEtFinservice')
AddEventHandler('police:PriseEtFinservice', function(PriseOuFin)
	local _source = source
	local _raison = PriseOuFin
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local name = xPlayer.getName(_source)

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('police:InfoService', xPlayers[i], _raison, name)
		end
	end
end)

-- Renfort

RegisterServerEvent('renfort')
AddEventHandler('renfort', function(coords, raison)
	local _source = source
	local _raison = raison
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('renfort:setBlip', xPlayers[i], coords, _raison)
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FOUILLE ----
-----------------

--[[RegisterNetEvent('police:confiscatePlayerItem')
AddEventHandler('police:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name == 'police' then
		if itemType == 'item_standard' then
			local targetItem = targetXPlayer.getInventoryItem(itemName)
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem(itemName, amount)
				TriggerClientEvent("esx:showNotification", source, "Vous avez volé ~g~"..amount..' '..sourceItem.label.."~s~.")
				TriggerClientEvent("esx:showNotification", target, "Il t'a été volé ~g~"..amount..' '..sourceItem.label.."~s~.")
			else
				--TriggerClientEvent("esx:showNotification", source, "~g~quantité invalide")
			end
			
		if itemType == 'item_account' then
			targetXPlayer.removeAccountMoney(itemName, amount)
			sourceXPlayer.addAccountMoney   (itemName, amount)
			
			TriggerClientEvent("esx:showNotification", source, "Vous avez volé ~g~"..amount.."€ ~s~Argent sale~s~.")
			TriggerClientEvent("esx:showNotification", target, "Il t'a été volé ~g~"..amount.."€ ~s~Argent sale~s~.")
			
		elseif itemType == 'item_weapon' then
			if amount == nil then amount = 0 end
			targetXPlayer.removeWeapon(itemName, amount)
			sourceXPlayer.addWeapon   (itemName, amount)

			TriggerClientEvent("esx:showNotification", source, "Vous avez volé ~g~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~g~"..amount.."~s~ munitions.")
			TriggerClientEvent("esx:showNotification", target, "Il t'a été volé ~g~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~g~"..amount.."~s~ munitions.")
		end
	end
end)]]


ESX.RegisterServerCallback('police:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~g~Tu es fouillé...")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)

--- Menotter

TriggerEvent('modo:LeyRider', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
	xPlayer.set('cuffState', {isCuffed = false, cuffMethod = nil})
end)

RegisterServerEvent('krz_handcuff:handcuff')
AddEventHandler('krz_handcuff:handcuff', function(target, wannacuff, method)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerTarget = ESX.GetPlayerFromId(target)
	local targetCuff = xPlayerTarget.get('cuffState')

	--if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(player))) > 50 then
		--DropPlayer(source, 'lol ta cru jsuis un fdp')
	--else
		if wannacuff then
			if not targetCuff.isCuffed then
				if method == 'policecuff' then
					TriggerClientEvent('krz_handcuff:arresting', xPlayer.source)
					TriggerClientEvent('krz_handcuff:thecuff', target, true, xPlayer.source)
					xPlayerTarget.set('cuffState', {isCuffed = true, cuffMethod = method})
				elseif method == 'basiccuff' then
					TriggerClientEvent('krz_handcuff:arresting', xPlayer.source)
					TriggerClientEvent('krz_handcuff:thecuff', target, true, xPlayer.source)
					xPlayerTarget.set('cuffState', {isCuffed = true, cuffMethod = method})
				end
			end
		elseif not wannacuff then
			if targetCuff.isCuffed then
				if (method == targetCuff.cuffMethod) or (method == 'all') then
					TriggerClientEvent('krz_handcuff:unarresting', xPlayer.source)
					TriggerClientEvent('krz_handcuff:thecuff', target, false)
					xPlayerTarget.set('cuffState', {isCuffed = false, cuffMethod = nil})
				else
					TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous ne pouvez démenottez cette personne')
				end
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous ne pouvez démenottez cette personne')
			end
		end
	--end
end)

ESX.RegisterUsableItem('basic_cuff', function(source)
	TriggerClientEvent('krz_handcuff:cbClosestPlayerID', source, true, 'basiccuff')
end)

ESX.RegisterUsableItem('basic_key', function(source)
	TriggerClientEvent('krz_handcuff:cbClosestPlayerID', source, false, 'basiccuff')
end)

ESX.RegisterUsableItem('police_cuff', function(source)
	TriggerClientEvent('krz_handcuff:cbClosestPlayerID', source, true, 'policecuff')
end)

ESX.RegisterUsableItem('police_key', function(source)
	TriggerClientEvent('krz_handcuff:cbClosestPlayerID', source, false, 'policecuff')
end)

ESX.RegisterUsableItem('lockpick', function(source)
	TriggerClientEvent('krz_handcuff:cbClosestPlayerID', source, false, 'all')
end)

-- Unhandcuff
ESX.AddGroupCommand('demenotter', "admin", function(source, args, user)
	local xPlayer

	if args[1] then
		xPlayer = ESX.GetPlayerFromId(args[1])
	else
		xPlayer = ESX.GetPlayerFromId(source)
	end

	if xPlayer then
		xPlayer.triggerEvent('krz_handcuff:thecuff', false)
		xPlayer.set('cuffState', {isCuffed = false, cuffMethod = nil})
	else
		ESX.ChatMessage(source, 'Player not online.')
	end
end, {help = "Se démenotter en urgence", params = { {name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"} }})

RegisterServerEvent('police:drag')
AddEventHandler('police:drag', function(target)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if xPlayer.job.name == 'police' then
  	TriggerClientEvent('police:drag', target, _source)
  end
end)

RegisterServerEvent('police:putInVehicle')
AddEventHandler('police:putInVehicle', function(target)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'police' then
  	TriggerClientEvent('police:putInVehicle', target)
	end
end)

RegisterServerEvent('police:OutVehicle')
AddEventHandler('police:OutVehicle', function(target)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == 'police' then
    	TriggerClientEvent('police:OutVehicle', target)
	end
end)

-- Ppa

RegisterNetEvent('donner:ppa')
AddEventHandler('donner:ppa', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 2500
    local xMoney = xPlayer.getMoney()
	local societyAccount

	if xPlayer.job.name == 'police' then
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
			societyAccount = account
		end)


				if price < societyAccount.money then

						societyAccount.removeMoney(price)

		else
			TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~g~d\'argent dans votre société")
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FOUILLE ----
-----------------

ESX.RegisterServerCallback('police:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent("esx:showAdvancedNotification", target, "Vous êtes en train de vous faire fouiller.", 5000, "danger")

	if xPlayer then
		local data = {
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

		cb(data)
	end
end)


ESX.RegisterServerCallback('esx_policejob:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local data = {
			name = GetPlayerName(target),
			job = xPlayer.job,
			job2 = xPlayer.job2,
			inventory = xPlayer.inventory,
			accounts = xPlayer.accounts,
			weapons = xPlayer.loadout,
			firstname = result[1]['firstname'],
			lastname = result[1]['lastname'],
			sex = result[1]['sex'],
			dob = result[1]['dateofbirth'],
			height = result[1]['height']
		}
	
		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			if licenses ~= nil then
				data.licenses = licenses
			end
		end)
	
		cb(data)
	end)
end)


-- Plaque

ESX.RegisterServerCallback('police:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT owner, vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then
			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname

				retrivedInfo.vehicle = json.decode(result[1].vehicle)

				cb(retrivedInfo)

			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

-- Facture

RegisterNetEvent("police:SendFacture")
AddEventHandler("police:SendFacture", function(target, price)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
			if account ~= nil then
				societyAccount = account
				local xPlayer = ESX.GetPlayerFromId(target)
				xPlayer.removeAccountMoney('bank', price)
				societyAccount.addMoney(price)
				TriggerClientEvent("esx:showNotification", target, "Votre compte en banque à été réduit de ~g~"..price.."e~s~.", 5000, "danger")
				TriggerClientEvent("esx:showNotification", source, "Vous avez donné une amende de ~g~"..price.."~s~e", 5000, "danger")
			end
		end)
	end
end)

InService = 0 
PlayerPolice = {}
Cellule = {}

RegisterNetEvent("ronflex:servicepolice")
AddEventHandler("ronflex:servicepolice", function(value)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "police" then 
        if value then 
            PlayerPolice[source] = source
            InService = InService+1
            for k, v in pairs(PlayerPolice) do 
                TriggerClientEvent("esx:showNotification", k, "~r~Central Police~s~~n~L'agent ~r~"..xPlayer.getName().." ~s~viens de prendre son service")
                TriggerClientEvent("ronflex:recieveagentpolice", k, InService)
            end
        else
            PlayerPolice[source] = nil
            InService = InService-1
            for k, v in pairs(PlayerPolice) do 
                TriggerClientEvent("esx:showNotification", k, "~r~Central Police~s~~n~L'agent ~r~"..xPlayer.getName().." ~s~viens de finir son service")
                TriggerClientEvent("ronflex:recieveagentpolice", k, InService)
            end
        end
    else
        print("ban")
    end
end)

RegisterNetEvent("ronflex:confiscateitem")
AddEventHandler("ronflex:confiscateitem", function(count, item, player, action, label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)
    if xPlayer.job.name == 'police' then 
        if PlayerPolice[source] then 
            if tPlayer then 
                if action == "item" then 
                    InfoItem = tPlayer.getInventoryItem(item)
                    if InfoItem.count >= tonumber(count) then 
                        tPlayer.removeInventoryItem(item, count)
                        xPlayer.addInventoryItem(item, count)
                    end
                    tPlayer.showNotification("Vous venez de vous faire confisquer ~r~"..count.."~s~ de "..InfoItem.label)
                    xPlayer.showNotification("Vous venez de confisquer ~r~"..count.."~s~ de "..InfoItem.label)
                elseif action == "weapon" then
                    InfoWeapon = tPlayer.getWeapon(item)
                    if InfoWeapon > 0 then 
                        tPlayer.removeWeapon(item)
                        xPlayer.addWeapon(item, 20)
                        tPlayer.showNotification("Vous venez de vous faire confisquer un/une "..label)
                        tPlayer.showNotification("Vous venez de confisquer un/une "..label)
                    else
                        print("Ban")
                    end
                else
                    print("Ban")
                end
            end
        else
            print("Ban")
        end
    else
        print("Ban")
    end
end)

ESX.RegisterServerCallback("ronfex:fouillepolicecb", function(source, cb, player)
    local tPlayer = ESX.GetPlayerFromId(player)
    if tPlayer then 
        infosplayer = {
            inventory = tPlayer.getInventory(),
            weapon = tPlayer.getLoadout()
        }
    end
    cb(infosplayer)
end)

RegisterNetEvent("ronflex:demandederenfort")
AddEventHandler("ronflex:demandederenfort", function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" then 
        if PlayerPolice[source] then 
            for k, v in pairs(PlayerPolice) do 
                if type == "pause" then 
                    TriggerClientEvent("esx:showNotification", k, "L'agent ~r~"..xPlayer.getName().."~s~ viens de se mettre en pause !")
                elseif type == 'control' then
                    TriggerClientEvent("esx:showNotification", k, "L'agent ~r~"..xPlayer.getName().."~s~ est actuellement en control !")
                elseif type == "retrourpdp" then 
                    TriggerClientEvent("esx:showNotification", k, "L'agent ~r~"..xPlayer.getName().."~s~ est en route vers le commisariat")
                else
                    TriggerClientEvent("esx:showNotification", k, "L'agent ~r~"..xPlayer.getName().."~s~ à besoin de renfort, je t'ai mis les coordonnées sur ton GPS !")
                    TriggerClientEvent("ronflex:demandederenfort", k, type, GetEntityCoords(GetPlayerPed(source)))
                end
            end
        else
            print("Ban")
        end
    end
end)

RegisterNetEvent("ronflex:miseencelule")
AddEventHandler("ronflex:miseencelule", function(player, timer, cellule)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" then 
        if #(GetEntityCoords(GetPlayerPed(source)) - vec3(464.716492, -995.723084, 24.915772)) < 30 then 
            if PlayerPolice[source] then
                local tPlayer = ESX.GetPlayerFromId(player)
                if tPlayer then 
                    if cellule == '1' then 
                        SetEntityCoords(GetPlayerPed(tPlayer.source), cfg_police.Cellule[1])
                    elseif cellule == "2" then 
                        SetEntityCoords(GetPlayerPed(tPlayer.source), cfg_police.Cellule[2])
                    elseif cellule == "3" then 
                        SetEntityCoords(GetPlayerPed(tPlayer.source), cfg_police.Cellule[3])
                    end
    
                    if not Cellule[tPlayer.identifier] then 
                        Cellule[tPlayer.identifier] = {}
                        Cellule[tPlayer.identifier].identifier = tPlayer.identifier
                        Cellule[tPlayer.identifier].timecellule = tonumber(timer)
                        Cellule[tPlayer.identifier].code = math.random(00000, 99999)
                        TriggerClientEvent("ronflex:settimerprison", tPlayer.source, timer, Cellule[tPlayer.identifier].code)
                    end
                end
            else
                print("ban")
            end
        else
            xPlayer.showNotification("Vous devez être au commisariat pour faire cela")
        end
      
    end
end)

RegisterNetEvent("armurie:giveweapon", function (weaponname)
	local source = source
	local xPlayer = ESX.GetPlayerFromId (source)
	xPlayer.addWeapon(weaponname, 255)
end)
