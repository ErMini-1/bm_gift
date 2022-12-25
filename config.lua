Config = {
    Locale = 'en',

    decorations = {
        mainTree = {
            enable = true,
            prop = "prop_xmas_ext",
            locations = {
                vec4(232.84, -882.32, 29.48, 332.72)
            }
        },

        smallTrees = {
            enable = true,
            prop = 'prop_xmas_tree_int',
            locations = {
                vec4(236.76, -876.6, 30.48, 338.36),
                vec4(234.0, -875.52, 30.48, 341.04),
            }
        },

        ped = {
            enable = true,

            -- @ If you have a santa claus ped, you can exchange it for this one.
            model = 'a_c_chimp',

            locations = {
                vec4(235.52, -876.04, 29.25, 336.64)
            }
        }
    },

    renderDist = 5.0,

    positions = {
        getGift = vec3(235.52, -876.04, 31.25)
    },

    rewards = {
        -- If you are using qb-core then u need to put the weapons into the items table.
        ['items'] = {
            {item = 'weapon_dagger', quantity = 1}
        }
    }
}

Languages = {
    ['en'] = {
        ['text3D'] = "Press ~g~E~w~ to get a gift",
        ['giftClaimed'] = "You have claimed your gift, Merry Christmas!",
        ['alreadyClaimed'] = "You have already claimed your gift."
    },
    ['es'] = {
        ['text3D'] = "Pulsa ~g~E~w~ para coger un regalo",
        ['giftClaimed'] = "Has reclamado tu regalo, Feliz Navidad!",
        ['alreadyClaimed'] = "Ya has reclamado tu regalo."
    }
}