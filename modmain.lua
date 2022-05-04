PrefabFiles = {
	"trashcan",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/trashcan.xml"),
}

local _G = GLOBAL
local STRINGS = _G.STRINGS
local RECIPETABS = _G.RECIPETABS
local Ingredient = _G.Ingredient
local TECH = _G.TECH
local getConfig = GetModConfigData
local Vector3 = _G.Vector3
local containers = _G.require "containers"

-- MAP ICON --

AddMinimapAtlas("images/inventoryimages/trashcan.xml")

-- STRINGS --

GLOBAL.STRINGS.NAMES.TRASHCAN = "Trash Can"
GLOBAL.STRINGS.RECIPE_DESC.TRASHCAN = "Throw away unwanted items."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.TRASHCAN = "It's a trash can."

-- RECIPE --

local recipeTabs = {
    RECIPETABS.TOOLS,
    RECIPETABS.SURVIVAL,
    RECIPETABS.FARM,
    RECIPETABS.SCIENCE,
    RECIPETABS.TOWN,
    RECIPETABS.REFINE,
    RECIPETABS.MAGIC,
}
local recipeTab = recipeTabs[getConfig("cfgRecipeTab")]

local recipeTechs = {
    TECH.NONE,
    TECH.SCIENCE_ONE, -- Science Machine
    TECH.SCIENCE_TWO, -- Alchemy Engine
    TECH.MAGIC_TWO, -- Prestihatitator
    TECH.MAGIC_THREE, -- Shadow Manipulator
    TECH.ANCIENT_TWO, -- Broken APS
    TECH.ANCIENT_FOUR, -- Repaired APS
}
local recipeTech = recipeTechs[getConfig("cfgRecipeTech")]

local trashcan = AddRecipe("trashcan",
	{Ingredient("cutstone", getConfig("cfgCutStones"))},
	recipeTab, recipeTech, "trashcan_placer", nil, nil, nil, nil, "images/inventoryimages/trashcan.xml")

-- CONTAINER --

local params = {}

params.trashcan = {
	widget = {
		slotpos = {},
		animbank = "ui_chest_3x2",
		animbuild = "ui_chest_3x2",
		pos = Vector3(0, 200, 0),
		side_align_tip = 160,
	},
	type = "chest",
}

for y = 1, 0, -1 do
	for x = 0, 2 do
		table.insert(params.trashcan.widget.slotpos, Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 120, 0))
	end
end

containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.trashcan.widget.slotpos ~= nil and #params.trashcan.widget.slotpos or 0)

local old_widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data, ...)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
    container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        old_widgetsetup(container, prefab, data, ...)
    end
end
