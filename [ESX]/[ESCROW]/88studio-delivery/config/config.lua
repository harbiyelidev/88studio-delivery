Config = {}

Config.Debug = false
Config.Language = 'en'
Config.SQL = 'oxmysql' -- oxmysql or ghmattimysql or mysql-async

Config.Interaction = {
    type = 'ox_target',
    text = {
        distance = 3.0,
        key = 'E',
        color = 'g'
    }
}

Config.ProfileImage = 'game'

Config.MaxTimetoDeliverPackage = 30
Config.MaximumTimeout = 5

Config.MileageUpdateInterval = 1200

Config.DutyPhone = {
    type = 'command', -- item or command or key
    command = {
        name = 'duty-phone',
        description = 'Open the duty phone',
    },
    key = {
        name = 'Z',
    },
    item = {
        name = 'duty-phone',
    },
}

Config.DutyTablet = {
    type = 'interaction', -- interaction or item or command
    interaction = {
        coords = vector4(222.48, 375.45, 106.38, 65.9),
        model = "a_m_y_bevhills_01",
        target = {
            label = "Panele Eriş",
            icon = "fas fa-utensils"
        },
        drawtext = {
            label = "Panele Eris",
        }
    },
    item = {
        name = 'duty-tablet',
    },
    command = {
        name = 'duty-tablet',
        description = 'Open the duty tablet',
    }
}

Config.Blip = {
    jobBlip = {
        enable = false,
        coords = vector3(222.0, 375.01, 106.37),
        label = '88Studio Deliverys',
        color = 27,
        sprite = 480,
        scale = 0.7,
    },
    carBlip = {
        sprite = 225,
        scale = 0.7,
        color = 5,
        route = true,
    },
    businessBlip = {
        color = 27,
        sprite = 430,
        scale = 0.7,
        route = true,
    },
    customerBlip = {
        color = 2,
        sprite = 500,
        scale = 0.7,
        route = true,
    },
    failBlip = {
        color = 1,
        sprite = 792,
        scale = 0.7,
        route = true,
    }
}

Config.Commands = {
    AddEXP = {
        enable = true,
        minRank = "admin",
        command = "delivery-add-exp",
        sendLog = true,
    },
    RemoveEXP = {
        enable = true,
        minRank = "admin",
        command = "delivery-remove-exp",
        sendLog = true,
    },
    ResetEXP = {
        enable = true,
        minRank = "admin",
        command = "delivery-reset-exp",
        sendLog = true,
    }
}

Config.NotifyTime = 3000

Config.GiveMoney = {
    moneyType = 'cash', -- cash or bank
    moneyIsItem = false,
    moneyItem = 'cash'
}

Config.NoAnotherVehicle = {
    enable = true,
    message = 'You may not drive a vehicle other than the one provided by the employer!'
}

Config.CheckVehicleDist = {
    enable = true,
    firstDistance = 30.0,
    secondDistance = 50.0,
    firstMessage = 'If you get any further away from the vehicle, the employer will cancel the job.',
    secondMessage = 'You are too far from the vehicle, the job is canceled. Deliver the vehicle from the point marked on the map!',
}

Config.CheckStatus = {
    OpenTablet = {
        enable = true,
        inTheVehicle = true,
        notDead = true,
        notHandcuffed = true,
        noWeapon = true,
    },
    DutyPhone = {
        enable = true,
        inTheVehicle = true,
        notDead = true,
        notHandcuffed = true,
        noWeapon = true,
    },
    RequestOrder = {
        enable = true,
        inTheVehicle = true,
        notDead = true,
        notHandcuffed = true,
        noWeapon = true,
    },
    TakePackage = {
        enable = true,
        inTheVehicle = true,
        notDead = true,
        notHandcuffed = true,
        noWeapon = true,
    },
    DeliverPackage = {
        enable = true,
        inTheVehicle = true,
        notDead = true,
        notHandcuffed = true,
        noWeapon = true,
    },
    RingBell = {
        enable = true,
        inTheVehicle = true,
        notDead = true,
        notHandcuffed = true,
        noWeapon = true,
    }
}

Config.Cars = {
    ['scooter'] = {
        model = 'blista',
    },
    ['normal'] = {
        model = 'jugular',
    },
    ['luxury'] = {
        model = 'dominator9',
    }
}

Config.Stage = {
    ['sweet'] = {
        requiredLevel = 0,
        vehicles = {
            ['1'] = {
                requiredLevel = 0,
            },
            ['2'] = {
                requiredLevel = 2,
            },
            ['3'] = {
                requiredLevel = 92,
            },
        },
        packageFee = {
            type = 'random', -- stable or random
            stable = 5,
            random = {
                min = 1,
                max = 5
            },
        },
        earnedXP = {
            type = 'stable', -- stable or random
            stable = 5,
            random = {
                min = 1,
                max = 5
            },
        },
    },
    ['pizzaria'] = {
        requiredLevel = 15,
        vehicles = {
            ['1'] = {
                requiredLevel = 1,
            },
            ['2'] = {
                requiredLevel = 2,
            },
            ['3'] = {
                requiredLevel = 3,
            },
        },
        packageFee = {
            type = 'stable', -- stable or random
            stable = 5,
            random = {
                min = 1,
                max = 5
            },
        },
        earnedXP = {
            type = 'stable', -- stable or random
            stable = 5,
            random = {
                min = 1,
                max = 5
            },
        },
    },
    ['hamburger'] = {
        requiredLevel = 30,
        vehicles = {
            ['1'] = {
                requiredLevel = 1,
            },
            ['2'] = {
                requiredLevel = 2,
            },
            ['3'] = {
                requiredLevel = 3,
            },
        },
        packageFee = {
            type = 'stable', -- stable or random
            stable = 5,
            random = {
                min = 1,
                max = 5
            },
        },
        earnedXP = {
            type = 'stable', -- stable or random
            stable = 5,
            random = {
                min = 1,
                max = 5
            },
        },
    }
}

VehicleKeys = function(plate)
    TriggerEvent('vehiclekeys:client:SetOwner', plate)
end