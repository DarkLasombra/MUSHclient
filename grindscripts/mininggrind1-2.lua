-- Define the steps for the grind path
steps = {
    -- Level 1 (Copper)
    {"spelunk"},
    {"se", "spelunk"},
    {"e", "spelunk"},
    {"e", "spelunk"},
    {"w", "n", "spelunk"},
    {"w", "spelunk"},
    {"e", "n", "spelunk"},
    {"e", "spelunk"},
    {"se", "spelunk"},
    {"nw", "w", "s", "s", "s", "spelunk"},
    {"se", "spelunk"},
    {"sw", "spelunk"},
    {"e", "spelunk"},
    {"e", "spelunk"},
    {"w", "w", "s", "spelunk"},
    {"s", "spelunk"},
    {"n", "n", "ne", "nw", "sw", "spelunk"},
    {"w", "spelunk"},
    {"w", "spelunk"},
    {"n", "spelunk"},
    {"s", "e", "sw", "spelunk"},
    {"s", "spelunk"},
    {"s", "spelunk"},
    {"nw", "spelunk"},
    {"n", "spelunk"},
    {"w", "spelunk"},
    {"s", "spelunk"},
    -- Level 2 (Bronze)
    {"n", "e", "s", "se", "n", "n", "ne", "e", "ne", "n", "w", "nw", "o", "mines 2", "spelunk"},
    {"se", "spelunk"},
    {"e", "spelunk"},
    {"e", "spelunk"},
    {"w", "n", "spelunk"},
    {"w", "spelunk"},
    {"e", "n", "spelunk"},
    {"e", "spelunk"},
    {"se", "spelunk"},
    {"nw", "w", "s", "s", "s", "spelunk"},
    {"se", "spelunk"},
    {"sw", "spelunk"},
    {"e", "spelunk"},
    {"e", "spelunk"},
    {"w", "w", "s", "spelunk"},
    {"s", "spelunk"},
    {"n", "n", "ne", "nw", "sw", "spelunk"},
    {"w", "spelunk"},
    {"w", "spelunk"},
    {"n", "spelunk"},
    {"s", "e", "sw", "spelunk"},
    {"s", "spelunk"},
    {"s", "spelunk"},
    {"nw", "spelunk"},
    {"n", "spelunk"},
    {"w", "spelunk"},
    {"s", "spelunk"},
    {"n", "e", "s", "se", "n", "n", "ne", "e", "ne", "n", "w", "nw", "exit"},

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