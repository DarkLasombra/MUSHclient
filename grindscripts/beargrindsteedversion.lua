-- Define the steps for the grind path
steps = {
    {"path", "n", "kill bear"},
    {"get all", "put all in steed", "enter", "kill bear"},
    {"get all", "put all in steed", "out", "e", "e", "kill bear"},
    {"get all", "put all in steed", "enter", "shake lump", "kill bear"},
    {"get all", "put all in steed", "out", "w", "s", "kill bear"},
    {"get all", "put all in steed", "n", "n", "kill bear"},
    {"get all", "put all in steed", "e", "pull latch", "d", "l at bed", "l at blanket", "search blanket", "kill bear"},
    {"get all", "put all in steed", "kill bear"},
    {"get all", "put all in steed", "u", "w", "s", "w", "w", "enter", "kill bear"},
    {"get all", "put all in steed", "out", "climb", "kill bear"},
    {"get all", "put all in steed", "kill bear"},
    {"get all", "put all in steed", "kill bear"},
    {"get all", "put all in steed", "s", "kill bear"},
    {"get all", "put all in steed", "n", "climb", "n", "e", "kill bear"},
    {"get all", "put all in steed", "n", "n", "kill bear"},
    {"get all", "put all in steed", "s", "s", "e", "rollout", "kill bear"},
    {"get all", "put all in steed", "search forest", "path", "w", "w", "kill elephant"},
    {"get all", "put all in steed", "n", "kill monkey"},
    {"get all", "put all in steed", "s", "s", "kill bear"},
    {"get all", "put all in steed", "kill bear"},
    {"get all", "put all in steed", "s", "kill bear"},
    {"get all", "put all in steed", "enter", "kill bear"},
    {"get all", "put all in steed", "kill lion"},
    {"get all", "put all in steed", "w", "kill raccoon"},
    {"get all", "put all in steed", "n", "knock on door", "open door", "kill bear"},
    {"get all", "put all in steed", "s", "e", "e", "kill pig"},
    {"get all", "put all in steed", "e", "kill rabbit"},
    {"get all", "put all in steed", "n", "n", "pry board", "d", "bend bars", "n", "turn latch", "open door", "poke embers", "grab diamond", "kill bear"},
    {"get all", "put all in steed", "s", "u", "n", "kill bear"},
    {"get all", "put all in steed", "n", "w", "kill professor"},
    {"get all", "put all in steed", "e", "sit chair", "enter", "sit and wait", "kill doctor"},
    {"search cabinets", "search pipes", "cut tape", "get package", "put package in back", "door", "s", "s", "s", "s", "s", "w", "w", "out", "n", "n", "e", "e", "e", "rollout", "castle", "enter", "w", "kill beastlie"},
    {"get all", "put all in steed", "e", "e", "me"},
    {"get all", "put all in steed", "w", "n", "n"},
    {"get all", "put all in steed", "open cage", "get diamond", "out", "fly back", "me"}
}


-- Global variables
currentStepIndex = 0
bearGrindActive = false
pauseGrind = false

-- Function to process the next step
function processNextStep()
    if not bearGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    -- Check if all steps are completed
    if currentStepIndex >= #steps then
        ColourNote("green", "black", "Grind path completed!")
        bearGrindActive = false
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
    if bearGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to start the grind
function startGrind()
    if bearGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    bearGrindActive = true
    currentStepIndex = 0
    ColourNote("cyan", "black", "Starting Bear grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    bearGrindActive = false
    ColourNote("red", "black", "Bear grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if bearGrindActive and pauseGrind then
        pauseGrind = false
        ColourNote("cyan", "black", "Resuming grind...")
        processNextStep()
    end
end