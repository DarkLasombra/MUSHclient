-- Define the steps for the grind path
treeSteps = {
    {"doorway", "kill angel"},
    {"g", "onward", "doorway", "kill angel"},
    {"g", "onward", "doorway", "kill angel"},
    {"g", "onward", "doorway", "kill angel"},
    {"g", "onward", "doorway", "kill angel"},
    {"g", "onward", "doorway", "kill angel"},
    {"g", "onward", "doorway", "kill angel"},
    {"g", "onward", "doorway", "kill angel"},
    {"g", "onward", "doorway", "kill angel"},
    {"g", "ta", "me"}
}

-- Global variables
currentTreeStepIndex = 0
treeGrindActive = false
pauseTreeGrind = false

-- Function to process the next step
function processNextStep()
    if not treeGrindActive then
        ColourNote("red", "black", "Treepath grind stopped.")
        return
    end

    -- Check if all steps are completed
    if currentTreeStepIndex >= #treeSteps then
        ColourNote("green", "black", "Treepath grind path completed!")
        treeGrindActive = false
        return
    end

    -- Move to the next step
    currentTreeStepIndex = currentTreeStepIndex + 1
    local commands = treeSteps[currentTreeStepIndex]

    -- Send all commands for this step
    for _, command in ipairs(commands) do
        Send(command)
    end
end

-- Trigger: Recovery Finished (advances to next step)
function onRecovery(name, line, wildcards)
    if treeGrindActive and not pauseTreeGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if treeGrindActive then
        ColourNote("yellow", "black", "Treepath grind already in progress!")
        return
    end

    treeGrindActive = true
    currentTreeStepIndex = 0
    ColourNote("cyan", "black", "Starting Treepath grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    treeGrindActive = false
    ColourNote("red", "black", "Treepath grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseTreeGrind = true
    ColourNote("yellow", "black", "Treepath grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if treeGrindActive and pauseTreeGrind then
        pauseTreeGrind = false
        ColourNote("cyan", "black", "Resuming Treepath grind...")
        processNextStep()
    end
end
