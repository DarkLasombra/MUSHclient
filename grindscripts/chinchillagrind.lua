-- Define the steps for the grind path
steps = {
    {"n", "n", "n", "n", "n", "e", "e", "e", "e", "e", "enter", "kill manager"},
    {"l at drawer", "open drawer", "push button", "enter", "kill ed"},
    {"w", "o", "o", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"s", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"s", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"s", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"s", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"s", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"s", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"w", "kill chinchilla"},
    {"s", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"e", "kill chinchilla"},
    {"w", "w", "w", "w", "w", "kill chinchilla"}
}


-- Global variables
currentStepIndex = 0
chinchillaGrindActive = false
pauseGrind = false
loopGrind = false  -- loop toggle flag (added)


-- Function to process the next step
function processNextStep()
    if not chinchillaGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    currentStepIndex = currentStepIndex + 1

    if currentStepIndex > #steps then
if loopGrind then
            currentStepIndex = 1
            ColourNote("cyan", "black", "Looping grind: restarting from the top.")
        else
        ColourNote("green", "black", "Grind path completed!")
        chinchillaGrindActive = false
        return
end
    end

        local commands = steps[currentStepIndex]

    -- Send all commands for this step
    for _, command in ipairs(commands) do
        Send(command)
    end
end

-- Trigger: Recovery Finished (advances to next step)
function onRecovery(name, line, wildcards)
    if chinchillaGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if chinchillaGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    chinchillaGrindActive = true
    currentStepIndex = 0
    ColourNote("cyan", "black", "Starting grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    chinchillaGrindActive = false
    ColourNote("red", "black", "Grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if chinchillaGrindActive and pauseGrind then
        pauseGrind = false
        ColourNote("cyan", "black", "Resuming grind...")
        processNextStep()
    end
end

-- Function to toggle looping of the grind (added)
function toggleLoopGrind()
    loopGrind = not loopGrind
    if loopGrind then
        ColourNote("cyan", "black", "Loop mode activated.")
    else
        ColourNote("yellow", "black", "Loop mode deactivated.")
    end
end