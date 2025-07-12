-- Define the steps for the grind path
steps = {
    {"n", "n", "portal", "w", "w", "w", "w", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "n", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "nw", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "n", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "n", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "nw", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "ne", "expandsense"},
    {"g", "pps", "n", "expandsense"},
    {"g", "pps", "s", "se", "se", "se", "e", "n", "expandsense"},
    {"g", "pps", "ne", "expandsense"},
    {"g", "pps", "s", "expandsense"},
    {"g", "pps", "s", "ne", "expandsense"},
    {"g", "pps", "nw", "n", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "ne", "expandsense"},
    {"g", "pps", "se", "expandsense"},
    {"g", "pps", "w", "s", "se", "s", "e", "e", "ne", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "e", "expandsense"},
    {"g", "pps", "ne", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "w", "expandsense"},
    {"g", "pps", "ne", "expandsense"},
    {"g", "pps", "n", "expandsense"},
    {"g", "pps", "s", "s", "s", "s", "s", "sw", "s", "w", "w", "w", "w", "w", "portal", "s", "s", "expandsense"}
        
}

-- Global variables
currentStepIndex = 0
mahjonggGrindActive = false
pauseGrind = false
currentTarget = nil
npcNames = { "butterfly", "dolphin", "dragon", "ox", "horse", "rat", "phoenix", "rabbit", "ram", "serpent", "tiger" }

-- Function to process the next step
function processNextStep()
    if not mahjonggGrindActive then
        ColourNote("red", "black", "Grind stopped.")
        return
    end

    -- Check if all steps are completed
    if currentStepIndex >= #steps then
        ColourNote("green", "black", "mahjongg grind path completed!")
        mahjonggGrindActive = false
        return
    end

    -- Move to the next step
    currentStepIndex = currentStepIndex + 1
    local commands = steps[currentStepIndex]

    -- Send all commands for this step
    for i = 1, #commands do
        Send(commands[i])
    end

    -- Enable NPC detection for the last command
    EnableTriggerGroup("npcDetection", true)
end

-- Trigger: Recovery Finished (advances to next step)
function onRecovery(name, line, wildcards)
    if mahjonggGrindActive and not pauseGrind then
        processNextStep()
    end
end

-- Function to handle NPC detection
function handleNpcDetection(line)
    if mahjonggGrindActive and not pauseGrind then
        local detectedNpc = line:match("^(%w+)$"):lower() -- Extract and convert to lowercase
        if table.contains(npcNames, detectedNpc) then
            currentTarget = detectedNpc -- Update the current target
        end
    end
end

-- Function to handle step end
function handleStepEnd(line)
    if mahjonggGrindActive and not pauseGrind then
        if currentTarget then
            Send("kill " .. currentTarget) -- Send target in lowercase
        else
            ColourNote("yellow", "black", "No target detected, skipping kill command.")
            processNextStep()
        end
    end
end

-- Function to start the grind
function startGrind()
    if mahjonggGrindActive then
        ColourNote("yellow", "black", "Grind already in progress!")
        return
    end

    mahjonggGrindActive = true
    currentStepIndex = 0
    currentTarget = nil
    ColourNote("cyan", "black", "Starting mahjongg grind...")
    processNextStep()
end

-- Function to stop the grind
function stopGrind()
    mahjonggGrindActive = false
    ColourNote("red", "black", "mahjongg grind stopped.")
end

-- Function to pause the grind
function pauseGrindFunction()
    pauseGrind = true
    ColourNote("yellow", "black", "Grind paused.")
end

-- Function to resume the grind
function resumeGrindFunction()
    if mahjonggGrindActive and pauseGrind then
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
