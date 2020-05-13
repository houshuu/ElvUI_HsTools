local W, F, E, L, V, P, G = unpack(select(2, ...))
local options = W.options.combat.args
local C = W:GetModule("CombatAlert")
local LSM = E.Libs.LSM

options.combatAlert = {
    order = 1,
    type = "group",
    name = L["Combat Alert"],
    desc = L["Show a alert when you enter or leave combat."],
    get = function(info)
        return E.db.WT.combat.combatAlert[info[#info]]
    end,
    set = function(info, value)
        E.db.WT.combat.combatAlert[info[#info]] = value
        C:ProfileUpdate()
    end,
    args = {
        enable = {
            order = 1,
            type = "toggle",
            name = L["Enable"]
        },
        speed = {
            order = 2,
            type = "range",
            name = L["Speed"],
            desc = L["The speed of the alert."],
            min = 0.1,
            max = 4,
            step = 0.01
        },
        animationConfig = {
            order = 3,
            type = "group",
            inline = true,
            name = L["Animation"],
            args = {
                animation = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"],
                    desc = L["Display an animation when you enter or leave combat."]
                },
                animationSize = {
                    order = 2,
                    type = "range",
                    name = L["Animation Size"],
                    desc = L["The speed of the alert."],
                    min = 0.1,
                    max = 3,
                    step = 0.01
                }
            }
        },
        textConfig = {
            order = 4,
            type = "group",
            inline = true,
            name = L["Text"],
            args = {
                text = {
                    order = 1,
                    type = "toggle",
                    name = L["Enable"],
                    desc = L["Display a text when you enter or leave combat."]
                },
                enterText = {
                    order = 2,
                    type = "input",
                    name = L["Text (Enter)"]
                },
                enterColor = {
                    order = 3,
                    type = "color",
                    name = L["Color (Enter)"],
                    get = function(info)
                        local db = E.db.WT.combat.combatAlert[info[#info]]
                        local default = P.combat.combatAlert[info[#info]]
                        return db.r, db.g, db.b, db.a, default.r, default.g, default.b, default.a
                    end,
                    set = function(info, r, g, b, a)
                        local db = E.db.WT.combat.combatAlert[info[#info]]
                        db.r, db.g, db.b, db.a = r, g, b, a
                    end
                },
                leaveText = {
                    order = 4,
                    type = "input",
                    name = L["Text (Leave)"]
                },
                leaveColor = {
                    order = 5,
                    type = "color",
                    name = L["Color (Leave)"],
                    get = function(info)
                        local db = E.db.WT.combat.combatAlert[info[#info]]
                        local default = P.combat.combatAlert[info[#info]]
                        return db.r, db.g, db.b, db.a, default.r, default.g, default.b, default.a
                    end,
                    set = function(info, r, g, b, a)
                        local db = E.db.WT.combat.combatAlert[info[#info]]
                        db.r, db.g, db.b, db.a = r, g, b, a
                    end
                },
                font = {
                    type = "group",
                    order = 6,
                    name = L["Font Setting"],
                    get = function(info)
                        return E.db.WT.combat.combatAlert[info[#info - 1]][info[#info]]
                    end,
                    set = function(info, value)
                        E.db.WT.combat.combatAlert[info[#info - 1]][info[#info]] = value
                        C:ProfileUpdate()
                    end,
                    args = {
                        name = {
                            order = 1,
                            type = "select",
                            dialogControl = "LSM30_Font",
                            name = L["Font"],
                            values = LSM:HashTable("font")
                        },
                        style = {
                            order = 2,
                            type = "select",
                            name = L["Outline"],
                            values = {
                                ["NONE"] = L["None"],
                                ["OUTLINE"] = L["OUTLINE"],
                                ["MONOCHROME"] = L["MONOCHROME"],
                                ["MONOCHROMEOUTLINE"] = L["MONOCROMEOUTLINE"],
                                ["THICKOUTLINE"] = L["THICKOUTLINE"]
                            }
                        },
                        size = {
                            order = 3,
                            name = L["Size"],
                            type = "range",
                            min = 5,
                            max = 60,
                            step = 1
                        }
                    }
                }
            }
        }
    }
}