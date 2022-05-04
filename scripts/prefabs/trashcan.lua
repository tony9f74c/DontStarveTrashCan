local assets = {
    Asset("ANIM", "anim/trashcan.zip"),
    Asset("ANIM", "anim/ui_chest_3x2.zip"),
}

local function onOpen(inst)
    inst.AnimState:PlayAnimation("open")
    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end

local function onClose(inst)
    inst.AnimState:PlayAnimation("burn")
    inst.SoundEmitter:PlaySound("dontstarve/common/fireBurstLarge")
    inst.components.container:DestroyContents()
end

local function onHammered(inst, worker)
    if inst.components.workable then
        inst:RemoveComponent("workable")
    end
    inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
    inst.AnimState:PlayAnimation("destroyed")
    inst:DoTaskInTime(0.5, function()
        inst:Remove()
    end)
end

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst:AddTag("structure")
    inst:AddTag("chest")
    inst:AddTag("trashcan")

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("trashcan.tex")

    inst.AnimState:SetBank("trashcan")
    inst.AnimState:SetBuild("trashcan")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then return inst end

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst:AddComponent("container")

    inst.components.container:WidgetSetup("trashcan")
    inst.components.container.onopenfn = onOpen
    inst.components.container.onclosefn = onClose

    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onHammered)

    MakeSnowCovered(inst)
    MakeSnowCoveredPristine(inst)
    AddHauntableDropItemOrWork(inst)

    return inst
end

return Prefab("common/trashcan", fn, assets),
        MakePlacer("common/trashcan_placer", "trashcan", "trashcan", "idle")
