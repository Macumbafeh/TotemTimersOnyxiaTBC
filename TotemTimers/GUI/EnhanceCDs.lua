local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

local SpellIDs = TotemTimers.SpellIDs


function TotemTimers.OrderCDs(role)
    for i = 1,#TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role] do
        TotemTimers.options.args.enhancecds.args[role].args[tostring(TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i])].order = i
    end
end

local function changeOrder(spell, dir, role)
    for i=1,TotemTimers.num_CD_Spells[role] do
        if TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i] == spell and i+dir>0 and i+dir<=TotemTimers.num_CD_Spells[role] then
            TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i],TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i+dir] =
                    TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i+dir],TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i]
            break
        end
    end
    TotemTimers.OrderCDs(role)
    TotemTimers.ProcessSpecSetting("EnhanceCDs")
end

TotemTimers.options.args.enhancecds = {
    type = "group",
    name = "enhancecds",
    args = {
        enable = {
            order = 0,
            type = "toggle",
            name = L["Enable"],
            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs end,
        }, 
        header = {
            order = 2,
            type = "header",
            name = "",
        },        
        CDTimersOnButtons = {
            order = 3,
            type = "toggle",
            name = L["Timers On Buttons"],
            set = function(info, val) TotemTimers.ActiveSpecSettings.CDTimersOnButtons = val
                        TotemTimers.ProcessSpecSetting("TimersOnButtons") end,
            get = function(info) return TotemTimers.ActiveSpecSettings.CDTimersOnButtons end,
        },  
        HideEnhanceCDsOOC = {
            order = 4,
            type = "toggle",
            name = L["Hide out of combat"],
            desc = L["Hide OOC Desc"],
            set = function(info, val) TotemTimers.ActiveSpecSettings.HideEnhanceCDsOOC = val  TotemTimers.ProcessSpecSetting("HideEnhanceCDsOOC") end,
            get = function(info) return TotemTimers.ActiveSpecSettings.HideEnhanceCDsOOC end,
        }, 
        OOCAlpha = {
            order = 6,
            type="range",
            min = 0,
            max = 1,
            step = 0.1,
            name = L["OOC Alpha"], 
            desc = L["OOC Alpha Desc"],
            set = function(info, val)
                        TotemTimers.ActiveSpecSettings.EnhanceCDsOOCAlpha = val  TotemTimers.ProcessSpecSetting("EnhanceCDsOOCAlpha")	
                  end,
            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDsOOCAlpha end,
        },
        scaling = {
            order = 10,
            type = "header",
            name = "Scaling",
        },
        ECDSize = {
            order = 11,
            type = "range",
            name = L["ECD Button Size"] ,
            min = 16,
            max = 96,
            step = 1,
            bigStep = 2,
            set = function(info, val)
                        TotemTimers.ActiveSpecSettings.EnhanceCDsSize = val  TotemTimers.ProcessSpecSetting("EnhanceCDsSize")	
                  end,
            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDsSize end,
        },
        ECDfontSize = {
            order = 12,
            type = "range",
            name = L["ECD Font Size"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveSpecSettings.EnhanceCDsTimeHeight = val  TotemTimers.ProcessSpecSetting("EnhanceCDsTimeHeight")	
                  end,
            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDsTimeHeight end,
        },
        maelstromheight = {
            order = 13,
            type = "range",
            name = L["Maelstrom Bar Height"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveSpecSettings.EnhanceCDsMaelstromHeight = val  TotemTimers.ProcessSpecSetting("EnhanceCDsMaelstromHeight")	
                  end,
            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDsMaelstromHeight end,
        },
        melee = {
            order = 15,
            type = "group",
            name = GetTalentTabInfo(2),
            args = {
                ["1"] = {
                    order = 1,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        stormstrike = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.StormStrike),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[1] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[1] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(1,1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(1,-1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },
                ["2"] = {
                    order = 2,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        earthshock = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.EarthShock),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[2] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[2] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(2,1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(2,-1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },
                ["3"] = {
                    order = 3,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        lavalash = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.LavaLash),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[3] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[3] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(3,1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(3,-1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },
                ["4"] = {
                    order = 4,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        firenova = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.FireNova),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[4] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[4] end,
                        },
                         down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(4,1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(4,-1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },                      
                    },
                },
                ["5"] = {
                    order = 5,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        magma = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.Magma),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[5] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[5] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(5,1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(5,-1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },    
                ["6"] = {
                    order = 6,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        shamanisticrage = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.ShamanisticRage),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[6] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[6] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(6,1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(6,-1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },    
                ["7"] = {
                    order = 7,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        windshear = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.WindShear),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[7] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[7] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(7,1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(7,-1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },
                ["8"] = {
                    order = 8,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        lightningshield = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.LightningShield),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[8] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[8] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(8,1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(8,-1,"melee") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },                 
                flameshock = {
                    order = 9,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FlameShock),
                    set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[9] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[9] end,
                }, 
                feralspirit = {
                    order = 10,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FeralSpirit),
                    set = function(info, val)TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[10] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[10] end,
                }, 
                maelstrom = {
                    order = 11,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.Maelstrom),
                    set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[11] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[11] end,
                }, 
            },
        },
        ele = {
            order = 16,
            type = "group",
            name = GetTalentTabInfo(1),
            args = {
                ["1"] = {
                    order = 1,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        flameshock = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.FlameShock),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[1] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[1] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(1,1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(1,-1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },
                ["2"] = {
                    order = 2,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        lavaburst = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.LavaBurst),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[2] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[2] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(2,1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(2,-1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },
                ["3"] = {
                    order = 3,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        chainlightning = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.ChainLightning),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[3] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[3] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(3,1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(3,-1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },
                ["4"] = {
                    order = 4,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        thunderstorm = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.Thunderstorm),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[4] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[4] end,
                        },
                         down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(4,1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(4,-1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },                      
                    },
                },
                ["5"] = {
                    order = 5,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        elementalmastery = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.ElementalMastery),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[5] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[5] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(5,1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(5,-1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                }, 
                ["6"] = {
                    order = 6,
                    type = "group",
                    inline = true,
                    name = "",
                    args = {
                        firenova = {
                            order = 1,
                            type = "toggle",
                            name = GetSpellInfo(SpellIDs.FireNova),
                            set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[6] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[6] end,
                        },
                        down = {
                            order = 2,
                            type = "execute",
                            name = "down",
                            func = function() changeOrder(6,1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                        up = {
                            order = 3,
                            type = "execute",
                            name = "up",
                            func = function() changeOrder(6,-1,"ele") end,
                            image = "Interface\\ChatFrame\\UI-ChatIcon-ScrollUp-Up",
                            width = "half",
                            imageWidth = 24,
                            imageHeight = 24,
                        },
                    },
                },                    
                flameshockduration = {
                    order = 8,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FlameShock).." ("..L["Duration"]..")",
                    set = function(info, val) TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[7] = val  TotemTimers.ProcessSpecSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[7] end,
                }, 
            },
        },
        heal = {
            order = 17,
            type = "group",
            name = GetTalentTabInfo(3),
            args = {
            },
        },
    },
}
    
local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["EnhanceCDs"], "TotemTimers", "enhancecds")    
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")