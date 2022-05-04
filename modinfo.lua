-- Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=755028761

name = "Trash Can"
description = "Throw away unwanted items."
author = "Tony" -- https://steamcommunity.com/profiles/76561198002269576
version = "1.2b"
forumthread = ""
api_version = 10
all_clients_require_mod = true
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"trash", "delete", "remove", "trashcan"}
priority = 0

local function setCount(k)
    return {description = ""..k.."", data = k}
end

local function setTab(k)
    local name = {"Tools", "Survival", "Farm", "Science", "Structures", "Refine", "Magic"}
    return {description = ""..name[k].."", data = k}
end

local function setTech(k)
    local name = {"None", "Science Machine", "Alchemy Engine", "Prestihatitator", "Shadow Manip.", "Broken APS", "Repaired APS"}
    return {description = ""..name[k].."", data = k}
end

local tab = {} for k=1,7,1 do tab[k] = setTab(k) end
local tech = {} for k=1,7,1 do tech[k] = setTech(k) end
local ingredient = {} for k=1,20,1 do ingredient[k] = setCount(k) end
local toggle = {{description = "Yes", data = true}, {description = "No", data = false},}

configuration_options = {
    {name = "cfgRecipeTab", label = "Recipe Tab", options = tab, default = 1, hover = "The crafting tab on which the recipe is found."},
    {name = "cfgRecipeTech", label = "Recipe Tech", options = tech, default = 1, hover = "The research building required to see/craft the recipe."},
    {name = "cfgCutStones", label = "How Many Cut Stones", options = ingredient, default = 1, hover = "The amount of Cut Stones required to craft."},
}
