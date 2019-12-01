-- Copyright (c) 2019 Localplayer
-- See the file LICENSE for copying permission.
-- Killsay v1.0
-- Say some shits on kill

local sentences = {
    "$name 1tap nub",
    "$name sit dog",
    "$name ez",
}

local ui = {
    new_checkbox = ui.new_checkbox,
    get = ui.get
}

local client = {
    set_event_callback = ui.set_event_callback,
    userid_to_entindex = client.userid_to_entindex,
    exec = client.exec
}

local entity = {
    get_local_player = entity.get_local_player,
    get_player_name = entity.get_player_name
}

local killsay_enabled = ui.new_checkbox("LUA", "A", "Enable killsay")

local function on_player_death(event)
    if not ui.get(killsay_enabled) then return end

    local local_player = entity.get_local_player()
    local attacker = client.userid_to_entindex(event.attacker)
    local victim = client.userid_to_entindex(event.userid)

    if local_player == nil or attacker == nil or victim == nil then
        return
    end

    if attacker == local_player and victim ~= local_player then
        local killsay = "say " .. sentences[math.random(#sentences - 1)]
        string.gsub(killsay, "%$victim", entity.get_player_name(victim))

        client.exec(killsay)
    end
end

client.set_event_callback("player_death", event)