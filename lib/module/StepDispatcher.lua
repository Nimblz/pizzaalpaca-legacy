local RunService = game:GetService("RunService")

local StepDispatcher = {}
local ModuleManager = nil

local function IsFunction(x)
    return (type(x) == "function")
end

local function StepModules(modules,time,dt)
    for _,module in pairs(modules) do
        if IsFunction(module.PreStep) then
            module.PreStep(time,dt)
        end
        if IsFunction(module.Step) then
            module.Step(time,dt)
        end
        if IsFunction(module.PostStep) then
            module.PostStep(time,dt)
        end
    end
end

function StepDispatcher.Init(moduleManager)
    ModuleManager = moduleManager
end

function StepDispatcher.Start()
    local Modules = ModuleManager:GetModules()

    RunService.Stepped:Connect(function(time,dt)
        StepModules(Modules,time,dt)
    end)
end



return StepDispatcher