Config = {}

Config.Relationships = {
    good = 250,
    medium = 100,
    bad = 50,
}

Config.Range = 3
Config.WaitTime = 5000
Config.AnswerWaitTime = 10000
Config.KeyForTalk = 'E'

Config.Cinematics = {
    [1] = {
        name = 'Silahci', 
        date = nil,
        whendontsayanything = 'Senin Biliceğin iş konuşmak istemiyosan bb',
        state = nil,
        relationship = nil,
        enable = false,
        Npc = {npc = nil, model = "g_f_y_families_01", coord = vector3(579.5626, -1318.95, 8.7307) ,heading = 15.0, created = false, animation = {dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_rear_lefthook", type = 2}}, -- {dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_rear_lefthook", type = 2}
        Subtitle = {
            Talk = {
                [1] = {
                    ['good'] = {
                        [1] = {
                            ped = "Selam Nasılsın ?",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                    ['bad'] = {
                        [1] = {
                            ped = "Kötü Deneme",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                    ['medium'] = {
                        [1] = {
                            ped = "Orta Deneme",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 5",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                },
                [2] = {
                    ['good'] = {
                        [1] = {
                            ped = "Selam Nasılsın ? Bebek",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                                [4] = {title = "Çok Güzel", relation = -3},
                                [5] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                    ['bad'] = {
                        [1] = {
                            ped = "Kötü Deneme",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                    ['medium'] = {
                        [1] = {
                            ped = "Orta Deneme",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                                [4] = {title = "Çok Güzel", relation = -3},
                                [5] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                                [4] = {title = "Çok Güzel", relation = -3},
                                [5] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                },  
            },
            Extra = {
                ['C4'] = {
                    ['good'] = "İSTER",
                    ['bad'] = "İSTEMEZ",
                    ['medium'] = "C5",
                },
                ['PISTOL'] = {
                    ['good'] = "C4 İSTER",
                    ['bad'] = "C4 İSTEMEZ",
                    ['medium'] = "C4",
                },
            },
        },
    },
    [2] = {
        name = 'Eskort', 
        date = nil,
        whendontsayanything = 'Senin Biliceğin iş konuşmak istemiyosan bb',
        state = nil,
        relationship = nil,
        enable = false,
        Npc = {npc = nil, model = "g_f_y_families_01", coord = vector3(579.5626, -1314.95, 8.7307) ,heading = 15.0, created = false, animation = {dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_rear_lefthook", type = 2}}, -- {dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_rear_lefthook", type = 2}
        Subtitle = {
            Talk = {
                [1] = {
                    ['good'] = {
                        [1] = {
                            ped = "Selam Nasılsın ?",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                    ['bad'] = {
                        [1] = {
                            ped = "Kötü Deneme",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                    ['medium'] = {
                        [1] = {
                            ped = "Orta Deneme",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 5",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                },
                [2] = {
                    ['good'] = {
                        [1] = {
                            ped = "Selam Nasılsın ? Bebek",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                                [4] = {title = "Çok Güzel", relation = -3},
                                [5] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                    ['bad'] = {
                        [1] = {
                            ped = "Kötü Deneme",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                    ['medium'] = {
                        [1] = {
                            ped = "Orta Deneme",
                            wait = 3,
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                                [4] = {title = "Çok Güzel", relation = -3},
                                [5] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                        [2] = {
                            ped = "Deneme 2",
                            wait = 3,
                            animation = {dict = "mp_ped_interaction", anim = "handshake_guy_a", type = 2, wait = 1},
                            selections = {
                                [1] = {title = "Hayatsız", relation = 10},
                                [2] = {title = "Olmak", relation = 5},
                                [3] = {title = "Çok Güzel", relation = -3},
                                [4] = {title = "Çok Güzel", relation = -3},
                                [5] = {title = "Çok Güzel", relation = -3},
                            },
                        },
                    },
                },  
            },
            Extra = {
                ['C4'] = {
                    ['good'] = "İSTER",
                    ['bad'] = "İSTEMEZ",
                    ['medium'] = "C5",
                },
                ['PISTOL'] = {
                    ['good'] = "C4 İSTER",
                    ['bad'] = "C4 İSTEMEZ",
                    ['medium'] = "C4",
                },
            },
        },
    },
}
