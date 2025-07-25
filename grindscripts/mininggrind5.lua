-- Define the steps for the new grind path with updated directions
steps = {
    -- Level 5 (Titanium and Ebon)
    {"spelunk"},
    {"g", "e", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "e", "spelunk"},
    {"g", "w", "s", "s", "s", "s", "spelunk"},
    {"g", "s", "spelunk"},
    {"g", "s", "spelunk"},
    {"g", "e", "spelunk"},
    {"g", "ne", "spelunk"},
    {"g", "ne", "spelunk"},
    {"g", "s", "spelunk"},
    {"g", "s", "spelunk"},
    {"g", "s", "spelunk"},
    {"g", "e", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "e", "spelunk"},
    {"g", "e", "spelunk"},
    {"g", "s", "spelunk"},
    {"g", "s", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "e", "spelunk"},
    {"g", "e", "spelunk"},
    {"g", "w", "w", "n", "e", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "n", "spelunk"},
    {"g", "w", "spelunk"},
    {"g", "sw", "spelunk"},
    {"g", "w", "spelunk"},
    {"g", "w", "spelunk"},
    {"g", "e", "e", "ne", "e", "s", "s", "w", "w", "w", "sw", "sw", "sw", "w", "n", "n", "n", "w", "exit", "me"}
}

-- Global variables
currentStepIndex = 0
miningGrindActive = false
pauseGrind = false

-- Function to process the next step
function processNextStep()
    if not miningGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    -- Check if all steps are completed
    if currentStepIndex >= #steps then
        ColourNote("green", "black", "Mining grind path completed!")
        miningGrindActive = false
        return
    end

    -- Move to the next step
    currentStepIndex = currentStepIndex + 1
    local commands = steps[currentStepIndex]

    -- Send all commands for this step
    for _, command in ipairs(commands) do
        Send(command)
    end
end

-- Trigger: Recovery Finished (advances to next step)
function onRecovery(name, line, wildcards)
    if miningGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if miningGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    miningGrindActive = true
    currentStepIndex = 0
    ColourNote("cyan", "black", "Starting Mining grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    miningGrindActive = false
    ColourNote("red", "black", "Mining grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if miningGrindActive and pauseGrind then
        pauseGrind = false
        ColourNote("cyan", "black", "Resuming grind...")
        processNextStep()
    end
end