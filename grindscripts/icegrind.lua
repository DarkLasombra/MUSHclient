-- Define the steps for the Ice grind path.
-- Each step is given as a table. For every step except for the first one,
-- we pre-pend the commands "g" and "pps", Also, the final command is replaced with "kill ice",

steps = {
    -- Step 1 (first step; no prefix)
    { "s", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "e", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "e", "n", "w", "n", "e", "n", "e", "e", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "s", "e", "n", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "s", "e", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "search", "w", "kill ice" },
    { "g", "pps", "e", "e", "n", "w", "n", "e", "n", "n", "e", "e", "s", "s", "s", "w", "s", "e", "s", "w", "s", "e", "s", "w", "s", "e", "e", "e", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "e", "n", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "w", "n", "e", "n", "w", "w", "n", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "e", "n", "w", "n", "e", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "w", "w", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "n", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "e", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "w", "kill ice" },
    { "g", "pps", "s", "kill ice" },
    { "g", "pps", "n", "e", "n", "w", "n", "e", "e", "e", "s", "w", "s", "e", "s", "w", "w", "s", "w", "s", "e", "s", "s", "s", "w", "w", "n", "n", "n", "n", "n", "n", "n", "kill ice" }
}

-- Global variables
currentStepIndex = 0
iceGrindActive = false
pauseGrind = false

-- Function to process the next step
function processNextStep()
    if not iceGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    -- Check if all steps are completed
    if currentStepIndex >= #steps then
        ColourNote("green", "black", "Ice grind path completed!")
        iceGrindActive = false
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

function onRecovery()
    -- does nothing; provided to prevent errors if called.
end

-- Trigger: Recovery Finished (advances to next step)
function iceNextStep(name, line, wildcards)
    if iceGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if iceGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    iceGrindActive = true
    currentStepIndex = 0
    ColourNote("cyan", "black", "Starting Ice grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    iceGrindActive = false
    ColourNote("red", "black", "Grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if iceGrindActive and pauseGrind then
        pauseGrind = false
        ColourNote("cyan", "black", "Resuming grind...")
        processNextStep()
    end
end