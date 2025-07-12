-- Define the steps for the grind path
steps = {
    {"s", "tactical", "kill letter"},
    {"s", "tactical", "kill letter"},
    {"e", "tactical", "kill letter"},
    {"w", "n", "e", "tactical", "kill letter"},
    {"e", "tactical", "kill letter"},
    {"e", "tactical", "kill letter"},
    {"e", "tactical", "kill letter"},
    {"s", "tactical", "kill letter"},
    {"n", "w", "w", "s", "tactical", "kill letter"},
    {"s", "tactical", "kill letter"},
    {"w", "tactical", "kill letter"},
    {"w", "tactical", "kill letter"},
    {"s", "tactical", "kill letter"},
    {"n", "e", "e", "e", "tactical", "kill letter"},
    {"n", "tactical", "kill letter"},
    {"s", "s", "tactical", "kill letter"},
    {"n", "e", "tactical", "kill letter"},
    {"s", "tactical", "kill letter"},
    {"s", "tactical", "kill letter"},
    {"e", "tactical", "kill letter"},
    {"w", "w", "tactical", "kill letter"},
    {"w", "tactical", "kill letter"},
    {"w", "tactical", "kill letter"},
    {"n", "tactical", "kill letter"},
    {"e", "tactical", "kill letter"},
    {"w", "s", "w", "tactical", "kill letter"},
    {"e", "e", "e", "e", "n", "n", "w", "w", "n", "n", "w", "w", "n", "tactical", "kill bear"}
}


-- Global variables
currentStepIndex = 0
alphabetGrindActive = false
pauseGrind = false

-- Function to process the next step
function processNextStep()
    if not alphabetGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    -- Check if all steps are completed
    if currentStepIndex >= #steps then
        ColourNote("green", "black", "Alphabet grind path completed!")
        alphabetGrindActive = false
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
    if alphabetGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if alphabetGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    alphabetGrindActive = true
    currentStepIndex = 0
    ColourNote("cyan", "black", "Starting Alphabet grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    alphabetGrindActive = false
    ColourNote("red", "black", "Alphabet grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if alphabetGrindActive and pauseGrind then
        pauseGrind = false
        ColourNote("cyan", "black", "Resuming grind...")
        processNextStep()
    end
end