-- Define the steps for the grind path
steps = {
    {"n", "n", "n", "n", "w", "w", "w", "kill charioteer"},
    {"g", "put all in bag", "e", "e", "kill priest"},
    {"g", "put all in bag", "e", "kill counsellor"},
    {"g", "put all in bag", "e", "e", "kill charioteer"},
    {"g", "put all in bag", "e", "kill king"},
    {"g", "put all in bag", "e", "s", "kill soldier"},
    {"g", "put all in bag", "w", "kill soldier"},
    {"g", "put all in bag", "w", "kill soldier"},
    {"g", "put all in bag", "w", "w", "kill soldier"},
    {"g", "put all in bag", "w", "kill soldier"},
    {"g", "put all in bag", "w", "kill refugee"},
    {"g", "put all in bag", "w", "s", "kill soldier"},
    {"g", "put all in bag", "e", "e", "kill horseman"},
    {"g", "put all in bag", "e", "kill priest"},
    {"g", "put all in bag", "e", "e", "kill horseman"},
    {"g", "put all in bag", "e", "e", "kill refugee"},
    {"g", "put all in bag", "s", "w", "kill priest"},
    {"g", "put all in bag", "w", "w", "kill soldier"},
    {"g", "put all in bag", "w", "kill priest"},
    {"g", "put all in bag", "w", "w", "kill soldier"},
    {"g", "put all in bag", "w", "s", "kill medic"},
    {"g", "put all in bag", "e", "e", "kill correspondent"},
    {"g", "put all in bag", "e", "e", "kill soldier"},
    {"g", "put all in bag", "e", "e", "e", "kill medic"},
    {"g", "put all in bag", "s", "w", "w", "kill horseman"},
    {"g", "put all in bag", "w", "w", "kill soldier"},
    {"g", "put all in bag", "w", "kill horseman"},
    {"g", "put all in bag", "w", "w", "s", "kill soldier"},
    {"g", "put all in bag", "e", "kill soldier"},
    {"g", "put all in bag", "e", "kill soldier"},
    {"g", "put all in bag", "e", "e", "e", "kill soldier"},
    {"g", "put all in bag", "e", "kill soldier"},
    {"g", "put all in bag", "e", "kill soldier"},
    {"g", "put all in bag", "s", "w", "kill king"},
    {"g", "put all in bag", "w", "kill charioteer"},
    {"g", "put all in bag", "w", "w", "kill counsellor"},
    {"g", "put all in bag", "w", "w", "w", "kill charioteer"},
    {"g", "put all in bag", "n", "n", "n", "n", "n", "n", "n", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "s", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "s", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "s", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "s", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "s", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "s", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "e", "kill animal"},
    {"g", "s", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "w", "kill animal"},
    {"g", "s", "kill animal"},
    {"g", "put all in bag", "e", "e", "e", "n", "n", "n", "kill poop"}
}


-- Global variables
currentStepIndex = 0
chessGrindActive = false
pauseGrind = false
loopGrind = false  -- loop toggle flag

-- Function to process the next step
function processNextStep()
    if not chessGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    currentStepIndex = currentStepIndex + 1

    if currentStepIndex > #steps then
        if loopGrind then
            currentStepIndex = 1
            ColourNote("cyan", "black", "Looping grind: restarting from the top.")
        else
            ColourNote("green", "black", "Chess grind path completed!")
            chessGrindActive = false
            return
        end
    end

    local commands = steps[currentStepIndex]
    for _, command in ipairs(commands) do
        Send(command)
    end
end

-- Trigger: Recovery Finished (advances to next step)
function onRecovery(name, line, wildcards)
    if chessGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if chessGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    chessGrindActive = true
    currentStepIndex = 0
    ColourNote("cyan", "black", "Starting Chess grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    chessGrindActive = false
    ColourNote("red", "black", "Chess grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if chessGrindActive and pauseGrind then
        pauseGrind = false
        ColourNote("cyan", "black", "Resuming grind...")
        processNextStep()
    end
end

-- Function to toggle looping of the grind
function toggleLoopGrind()
    loopGrind = not loopGrind
    if loopGrind then
        ColourNote("cyan", "black", "Loop mode activated.")
    else
        ColourNote("yellow", "black", "Loop mode deactivated.")
    end
end