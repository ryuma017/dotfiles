--
-- For simple keyboard remapping, I am currently using Karabiner, since it has
-- more low-level control over the keyboard. Eg, Karabiner has `vender_id` to
-- identify keyboards, which is useful for distinguishing between the laptop
-- keyboard and an external keyboard, which Hammerspoon does not.
--

local application = require("hs.application")
local hotkey   = require("hs.hotkey")
local eventtap = require("hs.eventtap")
local alert    = require("hs.alert")

local function launchOrFocusOrHide(name)

end

-- Create hotkeys with `hs.hotkey.new` instead of `hs.hotkey.bind`.
-- But these hotkeys will not take effect until left-alt is pressed.
local hotkeys = {
    -- health check
    hotkey.new({"alt", "ctrl", "shift"}, "h", function()
        alert.show("Hammerspoon is healthy!")
    end),
    -- launch/focus/hide Alacritty
    hotkey.new({"alt", "ctrl"}, "j", function()
        local name = "Alacritty"
        local app = application.find(name)
        if app == nil then
            application.launchOrFocus(name)
        elseif app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
     end),
    -- ...
}

-- This toggles the hotkeys on/off.
-- Use eventtap to detect flag changes only; this puts less strain on
-- Hammerspoon because it isn't having to deal with every single character
-- press.
local activated = false
_et = eventtap.new(
    { eventtap.event.types.flagsChanged },
    function(e)
        local flags = e:rawFlags()
        local masks = eventtap.event.rawFlagMasks
        if flags & masks.deviceLeftAlternate > 0 then
            if not activated then
                for _, v in ipairs(hotkeys) do
                    v:enable()
                end
                activated = true
            end
        else
            if activated then
                for _, v in ipairs(hotkeys) do
                    v:disable()
                end
                activated = false
            end
        end
    end
):start()
