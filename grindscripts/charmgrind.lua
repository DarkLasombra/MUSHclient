-- Define the steps for the grind path
steps = {
    {"e", "e", "search tree", "kill squirrel"},
    {"get charm", "e", "e", "e", "climb", "search rocks", "search rocks", "se", "n", "search river", "s", "w", "search tree", "kill mimicrywood"},
    {"get charm", "w", "search rock", "kill squirrel"},
    {"search rock", "w", "w", "w", "enter ring", "s", "se", "e", "ne", "n", "kill guardian"},
    {"get charm", "s", "sw", "w", "nw", "n", "portal", "w", "w", "w", "w", "search tree", "get charm", "w", "kill squirrel"},
    {"get charm", "n", "n", "e", "e", "e", "e", "snatch moon", "slide", "e", "e", "e", "e", "e", "wave lucky"}
}

-- Global variables
currentStepIndex = 0
charmGrindActive = false
pauseGrind = false

-- Function to process the next step
function processNextStep()
    if not charmGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    -- Check if all steps are completed
    if currentStepIndex >= #steps then
        ColourNote("green", "black", "charm grind path completed!")
        charmGrindActive = false
        return
    end

    -- Move to the next step
    currentStepIndex = currentStepIndex + 1
    local commands = steps[currentStepIndex]

    -- Send all commands for this step
    for i = 1, #commands do
        Send(commands[i])
    end

end

-- Trigger: Recovery Finished (advances to next step)
function onRecovery(name, line, wildcards)
    if charmGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to handle step end
function handleStepEnd(line)
    if charmGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if charmGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    charmGrindActive = true
    currentStepIndex = 0
    currentTarget = nil
    ColourNote("cyan", "black", "Starting charm grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    charmGrindActive = false
    ColourNote("red", "black", "charm grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if charmGrindActive and pauseGrind then
        pauseGrind = false
        ColourNote("cyan", "black", "Resuming grind...")
        processNextStep()
    end
end

-- Utility function to check if a table contains a value
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
