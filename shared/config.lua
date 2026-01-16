MatchSettings = {}

MatchSettings.Weapons = {
    ['heavy'] = {
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_CARBINERIFLE',
        'WEAPON_PUMPSHOTGUN',
        'WEAPON_SNIPERRIFLE',
    },
    ['melee'] = {
        'WEAPON_KNIFE',
        'WEAPON_BAT',
        'WEAPON_CROWBAR',
    },
    ['pistols'] = {
        'WEAPON_PISTOL',
        'WEAPON_COMBATPISTOL',
        'WEAPON_APPISTOL',
    },
}

MatchSettings.Arenas = {
    ['predio'] = {
        weaponLoadout = 'heavy',
        spawnPoints = {
            {x = 10.0, y = 20.0, z = 30.0, heading = 0.0},
            {x = 15.0, y = 25.0, z = 35.0, heading = 180.0},
        },
    },
    ['garagem'] = {
        weaponLoadout = 'pistols',
        spawnPoints = {
            {x = -10.0, y = -20.0, z = -30.0, heading = 90.0},
            {x = -15.0, y = -25.0, z = -35.0, heading = 270.0},
        },
    }
}