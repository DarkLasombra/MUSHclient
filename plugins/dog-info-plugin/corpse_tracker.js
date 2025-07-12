// --- CORPSE TRACKER BLOCK START ---

// Global variable to store corpse quantity
var corpseQty = 0;

/**
 * Updates corpse quantity from coffin (called by triggers with wildcard).
 * @param {number} qty - The new corpse quantity from inventory.
 */
function updateCorpseQtyFromCoffin(qty) {
    corpseQty = Number(qty) || 0;
}

/**
 * Increments corpse quantity by 1 (called by triggers).
 */
function addCorpse() {
    corpseQty += 1;
}

/**
 * Decrements corpse quantity by 1 (called by triggers).
 */
function removeCorpse() {
    if (corpseQty > 0) corpseQty -= 1;
}

/**
 * Returns current corpse quantity.
 * @returns {number}
 */
function getCorpseQty() {
    return corpseQty;
}

/**
 * Forces update by sending "i" to game to list inventory.
 * Assumes Send is available in the environment.
 */
function forceCorpseQtyUpdate() {
    Send("i");
}

// --- CORPSE TRACKER BLOCK END ---
