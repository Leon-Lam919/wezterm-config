local backdrops = require('utils.backdrops')
local wezterm = require('wezterm')
local act = wezterm.action

local keys = {
   -- Copy selected text to the clipboard
   {
      key = 'C',
      mods = 'CTRL|SHIFT',
      action = act.CopyTo('Clipboard'),
   },

   -- Paste text from the clipboard
   {
      key = 'V',
      mods = 'CTRL|SHIFT',
      action = act.PasteFrom('Clipboard'),
   },
   -- Rename the current tab
   {
      key = 'r',
      mods = 'CTRL|SHIFT',
      action = wezterm.action_callback(function(window, _pane)
         local new_title = window:show_input_box({
            prompt = 'Enter new tab title:',
         })
         if new_title and #new_title > 0 then
            window:perform_action(act.SetTabTitle(new_title), nil)
         else
            window:toast_notification('Rename Tab', 'Tab title cannot be empty!', nil, 3000)
         end
      end),
   },
   -- Cycle to the next tab
   { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },

   -- Cycle to the previous tab
   { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },

   -- misc/useful --
   { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
   { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
   { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
   { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
   { key = 'F5', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }) },
   { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
   { key = 'F12', mods = 'NONE', action = act.ShowDebugOverlay },

   -- Panes: tmux-like switching
   { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection('Left') },
   { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection('Down') },
   { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection('Up') },
   { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection('Right') },

   -- Panes: tmux-like closing
   { key = 'w', mods = 'CTRL', action = act.CloseCurrentPane({ confirm = false }) },

   -- Panes: splitting
   { key = 'h', mods = 'LEADER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
   { key = 'v', mods = 'LEADER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },

   -- Leader key-based commands
   { key = 'f', mods = 'LEADER', action = act.Search({ CaseInSensitiveString = '' }) },
   { key = 't', mods = 'LEADER', action = act.SpawnTab('DefaultDomain') },
   { key = 'w', mods = 'LEADER', action = act.CloseCurrentTab({ confirm = false }) },
}

return {
   disable_default_key_bindings = true,
   leader = { key = 'a', mods = 'CTRL' }, -- Leader key: CTRL+A
   keys = keys,
}
