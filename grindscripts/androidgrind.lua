-- Define the steps for the grind path
steps = {
    {"n", "kill fanboy"},
    {"w", "w", "w", "n", "n", "kill android"},
    {"e", "e", "kill android"},
    {"s", "w", "kill android"},
    {"s", "w", "kill android"},
    {"e", "e", "kill android"},
    {"e", "e", "n", "n", "kill android"},
    {"e", "e", "kill android"},
    {"s", "w", "kill android"},
    {"s", "w", "kill android"},
    {"e", "e", "kill android"},
    {"w", "w", "w", "push button"},
    {"w", "w", "w", "n", "n", "kill android"},
    {"e", "e", "kill android"},
    {"s", "w", "kill android"},
    {"gu", "s", "e", "e", "e", "e", "n", "kill android"},
    {"s", "w", "w", "push button"},
    {"stairs", "w", "n", "kill android"},
    {"s", "e", "e", "n", "kill android"},
    {"s", "w", "w", "kill android"},
    {"e", "e", "kill android"},
    {"w", "stairs", "s", "me"}
}

-- Global variables
currentStepIndex = 0
androidGrindActive = false
pauseGrind = false

-- Function to process the next step
function processNextStep()
    if not androidGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    -- Check if all steps are completed
    if currentStepIndex >= #steps then
        ColourNote("green", "black", "Grind path completed!")
        androidGrindActive = false
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
    if androidGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if androidGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    androidGrindActive = true
    currentStepIndex = 0
    ColourNote("cyan", "black", "Starting grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    androidGrindActive = false
    ColourNote("red", "black", "Grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if androidGrindActive and pauseGrind then
        pauseGrind = false
        ColourNote("cyan", "black", "Resuming grind...")
        processNextStep()
    end
end