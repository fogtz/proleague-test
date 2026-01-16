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
        name = 'Prédio',
        weaponLoadout = 'heavy',
        spawnPoints = {
            { x = -773.43, y = -608.03, z = 96.2, heading = 180.0 },
            { x = -773.38, y = -628.27, z = 96.2, heading = 0.0 },
        },
    },
    ['garagem'] = {
        name = 'Garagem',
        weaponLoadout = 'pistols',
        spawnPoints = {
            { x = -285.99, y = -765.86, z = 43.61, heading = 68.04 },
            { x = -315.28, y = -755.26, z = 43.61, heading = 249.45 },
        },
    }
}