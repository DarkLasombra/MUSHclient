-- buffs.lua

local buffs = {}

function AddBuff(buffName, duration)
    buffs[buffName] = duration
end

function RemoveBuff(buffName)
    buffs[buffName] = nil
end

-- Removed the UpdateBuffs decrement loop as the buff values are now updated via the snapshot trigger.

function GetActiveBuffs()
    local activeBuffs = {}
    for buffName, duration in pairs(buffs) do
        if duration and duration > 0 then
            table.insert(activeBuffs, {name = buffName, rounds = duration})
        end
    end
    return activeBuffs
end

function ParseBuffMessage(message)
    local addBuffPattern = "You gain (.+) for (%d+) rounds"
    local removeBuffPattern = "Your (.+) fades"

    local addBuffName, addBuffDuration = message:match(addBuffPattern)
    if addBuffName and addBuffDuration then
        AddBuff(addBuffName, tonumber(addBuffDuration))
    end

    local removeBuffName = message:match(removeBuffPattern)
    if removeBuffName then
        RemoveBuff(removeBuffName)
    end
end

function UpdateBuffDisplay()
    local activeBuffs = GetActiveBuffs()
    -- Logic to update the mini window display with active buffs
    -- This would involve calling functions from Buff_Tracker_Miniwindow.xml
end

-- OnUpdate now only refreshes the display,
-- relying on the new snapshot trigger from the buff tracker to update buff durations.
function OnUpdate()
    UpdateBuffDisplay()
end

-- Example usage: Call ParseBuffMessage with the message received from the game
-- ParseBuffMessage("You gain Speed for 5 rounds")