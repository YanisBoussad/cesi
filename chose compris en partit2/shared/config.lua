cfg_policeWebhookRendezVousPolice = "https://discord.com/api/webhooks/968621621504008283/JXNhziaAfY3IyVdLtKRxBTZEyb5YDjcEiuNXWmSkQxba2JKyTc2XkWk2DiS21syVGN_m" -- Metez le webhook de votre salon disocrd cfg_policeure pour le job ems 

cfg_police = {

    Cellule = {
        [1] = vec3(460.074738, -994.272522, 24.915772),
        [2] = vec3(459.520874, -997.832946, 24.915772),
        [3] = vec3(459.191224, -1001.525268, 24.915772)
    },
    
     MarkerType = 6, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
     MarkerSizeLargeur = 0.55, -- Largeur du marker
     MarkerSizeEpaisseur = 0.55, -- Épaisseur du marker
     MarkerSizeHauteur = 0.55, -- Hauteur du marker
     MarkerDistance = 4.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
     MarkerColorR = 69, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
     MarkerColorG = 112, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
     MarkerColorB = 246, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
     MarkerOpacite = 180, -- Opacité du marker (min: 0, max: 255)
     MarkerSaute = false, -- Si le marker saute (true = oui, false = non)
     MarkerTourne = false, -- Si le marker tourne (true = oui, false = non)

     TextCoffre = "Appuyez sur ~b~[E] ~s~pour accèder au ~b~coffre ~s~!",  -- Text Menu coffre
     TextVestaire = "Appuyez sur ~b~[E] ~s~pour pour accèder au ~b~vestaire ~s~!", -- Text Menu Vestaire
     TextGarageVehicule = "Appuyez sur ~b~[E] ~s~pour accèder au ~b~garage ~s~!",  -- Text Garage Voiture
     TextRentreVehicule = "Appuyez sur ~b~[E] ~s~pour ranger le ~b~véhicule ~s~!",  -- Text Rentré Voiture
     TextGarageHeli = "Appuyez sur ~b~[E] ~s~pour accèder au ~b~garage ~s~!",  -- Text Garage Hélico
     TextAccueil = "Appuyez sur ~b~[E] ~s~pour parler a la secrétaire ~s~!",  -- Text Ascenseur

 VehiculesPolice = { 
 	{buttoname = "                       ↓ Liste des Véhicules ↓                                                ", disc = "Recuit", rightlabel = "→→", spawnname = "", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Ford Victoria", disc = "Recuit", rightlabel = "→→", spawnname = "police", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Dodge", disc = "Officier I", rightlabel = "→→", spawnname = "police2", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Ford Explorer", disc = "Officier I", rightlabel = "→→", spawnname = "police3", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Lexus GS 350", disc = "Officier II", rightlabel = "→→", spawnname = "polgs350", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Véhicule SWAT", disc = "Spesialisation SWAT", rightlabel = "→→", spawnname = "fbi2", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Moto Recrue Mary", disc = "Spesialisation Mary", rightlabel = "→→", spawnname = "policeb", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Moto Expert", disc = "Spesialisation Mary", rightlabel = "→→", spawnname = "r1200rtp", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "R.I.O.T", disc = "Spesialisation SWAT", rightlabel = "→→", spawnname = "riot", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "R.I.O.T 2", disc = "Spesialisation SWAT", rightlabel = "→→", spawnname = "riot2", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Bus Pénitencier", disc = "Spesialisation SWAT", rightlabel = "→→", spawnname = "pbus", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Felon", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "policefelon", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Range Rover", disc = "Spesialisation BI", rightlabel = "→→", spawnname = "rover", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Maserati", disc = "Spesialisation TD", rightlabel = "→→", spawnname = "ghispo2", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture
    {buttoname = "Dodge Chargeur", disc = "Spesialisation TD", rightlabel = "→→", spawnname = "sjcop1", spawnzone = vector3(437.0840, -986.215, 25.69), headingspawn = 270.174}, -- Garage Voiture

},

HelicoPolice = { 
 	{buttonameheli = "Hélicoptère", rightlabel = "→→", spawnnameheli = "polmav", spawnzoneheli = vector3(449.1641, -981.3759, 43.6913), headingspawnheli = 93.3062}, -- Garage Hélico
},

 amende = {
    ["amende "] = {
        {label = 'Usage abusif du klaxon', price = 1500},
        {label = 'Franchir une ligne continue', price = 1500},
        {label = 'Circulation à contresens', price = 1500},
        {label = 'Demi-tour non autorisé', price = 1500},
        {label = 'Circulation hors-route', price = 1500},
        {label = 'Non-respect des distances de sécurité', price = 1500},
        {label = 'Arrêt dangereux / interdit', price = 1500},
        {label = 'Stationnement gênant / interdit', price = 1500},
        {label = 'Non respect  de la priorité à droite', price = 1500},
        {label = 'Non-respect à un véhicule prioritaire', price = 1500},
        {label = 'Non-respect d\'un stop', price = 1500},
        {label = 'Non-respect d\'un feu rouge', price = 1500},
        {label = 'Dépassement dangereux', price = 1500},
        {label = 'Véhicule non en état', price = 1500},
        {label = 'Conduite sans permis', price = 1500},
        {label = 'Délit de fuite', price = 1500},
        {label = 'Excès de vitesse < 5 kmh', price = 1500},
        {label = 'Excès de vitesse 5-15 kmh', price = 1500},
        {label = 'Excès de vitesse 15-30 kmh', price = 1500},
        {label = 'Excès de vitesse > 30 kmh', price = 1500},
        {label = 'Entrave de la circulation', price = 1500},
        {label = 'Dégradation de la voie publique', price = 1500},
        {label = 'Trouble à l\'ordre publique', price = 1500},
        {label = 'Entrave opération de police', price = 1500},
        {label = 'Insulte envers / entre civils', price = 1500},
        {label = 'Outrage à agent de police', price = 1500},
        {label = 'Menace verbale ou intimidation envers civil', price = 1500},
        {label = 'Menace verbale ou intimidation envers policier', price = 1500},
        {label = 'Manifestation illégale', price = 1500},
        {label = 'Tentative de corruption', price = 1500},
        {label = 'Arme blanche sortie en ville', price = 1500},
        {label = 'Arme léthale sortie en ville', price = 1500},
        {label = 'Port d\'arme non autorisé (défaut de license)', price = 1500},
        {label = 'Port d\'arme illégal', price = 1500},
        {label = 'Pris en flag lockpick', price = 1500},
        {label = 'Vol de voiture', price = 1500},
        {label = 'Vente de drogue', price = 1500},
        {label = 'Fabriquation de drogue', price = 1500},
        {label = 'Possession de drogue', price = 1500},
        {label = 'Prise d\'ôtage civil', price = 1500},
        {label = 'Prise d\'ôtage agent de l\'état', price = 1500},
        {label = 'Braquage particulier', price = 1500},
        {label = 'Braquage magasin', price = 1500},
        {label = 'Braquage de banque', price = 1500},
        {label = 'Tir sur civil', price = 1500},
        {label = 'Tir sur agent de l\'état', price = 1500},
        {label = 'Tentative de meurtre sur civil', price = 1500},
        {label = 'Tentative de meurtre sur agent de l\'état', price = 1500},
        {label = 'Meurtre sur civil', price = 1500},
        {label = 'Meurte sur agent de l\'état', price = 1500}, 
        {label = 'Escroquerie à l\'entreprise', price = 1500},
    }
},

PoliceCloak = {
    clothes = {
        specials = {
            [0] = {
                label = "Reprendre sa tenue : ~g~Civile",
                 minimum_grade = 0,
                variations = {male = {}, female = {}},
                onEquip = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin) TriggerEvent('skinchanger:loadSkin', skin) end)
                    SetPedArmour(PlayerPedId(), 0)
                end
            },
        },

        grades = {

            [1] = {
                label = "S'équiper de la tenue : ~b~Cadet",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 69,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 8,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 19,
                        ['pants_1'] = 111,   ['pants_2'] = 0,
                        ['shoes_1'] = 88,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 51,     ['bags_2'] = 0,
                        ['bproof_1'] = 27,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 0,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [2] = {
                label = "S'équiper de la tenue : ~b~Officier I",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 69,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 8,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 19,
                        ['pants_1'] = 111,   ['pants_2'] = 0,
                        ['shoes_1'] = 88,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 51,     ['bags_2'] = 0,
                        ['bproof_1'] = 26,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [3] = {
                label = "S'équiper de la tenue : ~b~Officier II",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 69,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 8,
                        ['decals_1'] = 1,   ['decals_2'] = 0,
                        ['arms'] = 19,
                        ['pants_1'] = 111,   ['pants_2'] = 0,
                        ['shoes_1'] = 88,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 51,     ['bags_2'] = 0,
                        ['bproof_1'] = 26,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [4] = {
                label = "S'équiper de la tenue : ~b~Major",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 69,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 8,
                        ['decals_1'] = 2,   ['decals_2'] = 0,
                        ['arms'] = 19,
                        ['pants_1'] = 111,   ['pants_2'] = 0,
                        ['shoes_1'] = 88,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 51,     ['bags_2'] = 0,
                        ['bproof_1'] = 7,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 137,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },


            [5] = {
                label = "S'équiper de la tenue : ~b~Sergent",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 69,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 8,
                        ['decals_1'] = 8,   ['decals_2'] = 0,
                        ['arms'] = 19,
                        ['pants_1'] = 111,   ['pants_2'] = 0,
                        ['shoes_1'] = 88,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 51,     ['bags_2'] = 0,
                        ['bproof_1'] = 7,  ['bproof_2'] = 4,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 136,   ['decals_2'] = 2,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 1,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [6] = {
                label = "S'équiper de la tenue : ~b~Sergent Chef",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 69,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 8,
                        ['decals_1'] = 7,   ['decals_2'] = 0,
                        ['arms'] = 19,
                        ['pants_1'] = 111,   ['pants_2'] = 0,
                        ['shoes_1'] = 88,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 51,     ['bags_2'] = 0,
                        ['bproof_1'] = 7,  ['bproof_2'] = 4,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 136,   ['decals_2'] = 3,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 1,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [7] = {
                label = "S'équiper de la tenue : ~b~Lieutenant",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 69,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 8,
                        ['decals_1'] = 7,   ['decals_2'] = 0,
                        ['arms'] = 19,
                        ['pants_1'] = 111,   ['pants_2'] = 0,
                        ['shoes_1'] = 88,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 51,     ['bags_2'] = 0,
                        ['bproof_1'] = 31,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 142,   ['decals_2'] = 0,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 2,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [8] = {
                label = "S'équiper de la tenue : ~b~Lieutenant Colonel",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 135,   ['decals_2'] = 1,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 3,
                        ['bproof_1'] = 113,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 142,   ['decals_2'] = 1,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 3,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [9] = {
                label = "S'équiper de la tenue : ~b~Capitaine",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 130,   ['decals_2'] = 1,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_1'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 136,   ['decals_2'] = 1,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 0,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

            [10] = {
                label = "S'équiper de la tenue : ~b~Commandant",
                minimum_grade = 0,
                variations = {
                    male = {
                        ['tshirt_1'] = 248,  ['tshirt_2'] = 0,
                        ['torso_1'] = 417,   ['torso_2'] = 1,
                        ['decals_1'] = 135,   ['decals_2'] = 2,
                        ['arms'] = 4,
                        ['pants_1'] = 146,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 173,    ['chain_2'] = 0,
                        ['bags_1'] = 103,     ['bags_2'] = 5,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    },
                    female = {
                        ['tshirt_1'] = 245,  ['tshirt_2'] = 0,
                        ['torso_1'] = 419,   ['torso_2'] = 1,
                        ['decals_1'] = 142,   ['decals_2'] = 2,
                        ['arms'] = 1,
                        ['pants_1'] = 150,   ['pants_2'] = 0,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['chain_1'] = 183,    ['chain_2'] = 0,
                        ['bags_1'] = 102,     ['bags_2'] = 5,
                        ['bproof_1'] = 81,  ['bproof_2'] = 0,
                    }
            },
                onEquip = function()
                end
            },

        }
    }
},

armurie = {
    {
        grade = "Cadet",
        minimum_grade = 0,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "weapon_flashlight",
            "weapon_stungun",
            "WEAPON_NIGHTSTICK"
        }
    },
    {
        grade = "Officier",
        minimum_grade = 1,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
        }
    },
    {
        grade = "Officier I",
        minimum_grade = 2,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
        }
    },
    {
        grade = "Officier II",
        minimum_grade = 3,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
        }
    },
    {
        grade = "Major",
        minimum_grade = 4,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
        }
    },
    {
        grade = "Sergent",
        minimum_grade = 5,
        weapons = {
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Sergent Chef",
        minimum_grade = 6,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Lieutenant",
        minimum_grade = 7,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
        }
    },
    {
        grade = "Lieutenant Colonel",
        minimum_grade = 8,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
    --        "WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Capitaine Adjoint",
        minimum_grade = 9,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Capitaine",
        minimum_grade = 10,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Commandant Adjoint",
        minimum_grade = 11,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            --"WEAPON_SNIPERRIFLE"
        }
    },
    {
        grade = "Commandant",
        minimum_grade = 12,
        weapons = {
            "WEAPON_COMBATPISTOL",
            "WEAPON_CARBINERIFLE",
            "WEAPON_PUMPSHOTGUN",
            "WEAPON_NIGHTSTICK",
            "WEAPON_STUNGUN",
            "WEAPON_FLASHLIGHT",
            "WEAPON_SNIPERRIFLE"
        }
    }
},

Position = {
 	    Coffre = {vector3(448.94113, -997.3993, 29.6895)}, -- Menu coffre 
        Vestaire = {vector3(461.07910, -996.447937, 29.73)}, -- Menu Vestaire 
        Accueil = {vector3(441.15133, -981.8668, 30.68)}, -- Menu Pour Accueil 
        GarageVehicule = {vector3(441.53, -984.64, 24.7)}, -- Menu Garage Vehicule
        RentreVehicule = {vector3(446.01, -988.75, 24.7)}, -- Menu Garage Vehicule
 	    GarageHeli = {vector3(463.32, -982.25, 42.69)}, -- Menu Garage Helico
    },

    props = {
        {label = "Police Barrière", prop = "prop_barrier_work05"},
        {label = "Cone", prop = "prop_roadcone02a"},
        {label = "Herse", prop = "p_ld_stinger_s"}
    }
}


function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function CheckQuantity(number)
    number = tonumber(number)
    if type(number) == "number" then
        number = ESX.Math.Round(number)

        if number > 0 then
            return true, number
        end
    end
    return false, number
end


function PlayerMarker(player)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)
    DrawMarker(2, pos.x, pos.y, pos.z+1.0, 0.0, 0.0, 0.0, 179.0, 0.0, 0.0, 0.25, 0.25, 0.25, 81, 203, 231, 200, 0, 1, 2, 1, nil, nil, 0)
end