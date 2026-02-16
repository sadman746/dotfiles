local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.initial_cols = 180
config.initial_rows = 50

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19

--configurazione tastiera
config.use_dead_keys = true
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

-- KEYBINDINGS
config.keys = {
  -- Split verticale (pane a destra)
  {
    key = "d",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  -- Split orizzontale (pane sotto)
  {
    key = "D",
    mods = "CMD|SHIFT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  -- Chiudi pane
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  -- Muovi tra i pane
  {
    key = "h",
    mods = "CMD|ALT",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "CMD|ALT",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "CMD|ALT",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "CMD|ALT",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  -- Zoom pane (fullscreen temporaneo)
  {
    key = "Enter",
    mods = "CMD|SHIFT",
    action = wezterm.action.TogglePaneZoomState,
  },
  -- Nuova finestra
  {
    key = "n",
    mods = "CMD|SHIFT",
    action = wezterm.action.SpawnWindow,
  },
  -- Ricarica config
  {
    key = "r",
    mods = "CMD|SHIFT",
    action = wezterm.action.ReloadConfiguration,
  },
  -- Copia
  {
    key = "c",
    mods = "CMD",
    action = wezterm.action.CopyTo("Clipboard"),
  },
  -- Incolla
  {
    key = "v",
    mods = "CMD",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
  -- Selezione rettangolare
  {
    key = "b",
    mods = "CMD|SHIFT",
    action = wezterm.action.ActivateCopyMode,
  },
  -- Cancella linea (Ctrl+U come in terminale)
  {
    key = "u",
    mods = "CTRL",
    action = wezterm.action.SendString("\x15"),
  },
  -- Aumenta font size
  {
    key = "=",
    mods = "CMD",
    action = wezterm.action.IncreaseFontSize,
  },
  -- Diminuisci font size
  {
    key = "-",
    mods = "CMD",
    action = wezterm.action.DecreaseFontSize,
  },
  -- Reset font size
  {
    key = "0",
    mods = "CMD",
    action = wezterm.action.ResetFontSize,
  },
}

return config
