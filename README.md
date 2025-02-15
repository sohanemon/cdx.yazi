# cdx - Change Directory Extended

A [Yazi](https://yazi-rs.github.io/) plugin that enhances directory navigation with smart path resolution, fallback strategies, and configuration support.

## Features

- **Smart Path Resolution:** Handles both absolute and relative paths.
- **Multiple Fallbacks:** Tries several strategies to find a valid directory.
- **Configurable:** Customize behavior via a `sohanscript.json` file.
- **$NVIM_CWD Integration:** (Requires [Yazi.nvim](https://github.com/mikavilpas/yazi.nvim))
- **User Notifications:** Alerts when a path is invalid.
- **Extensible:** Easily add custom path handling.

## Installation

### Git Clone

```sh
git clone https://github.com/sohanemon/cdx.yazi ~/.config/yazi/plugins/cdx.yazi
```

### Using `ya`

```sh
ya pack -a sohanemon/cdx
```

### Using `lazy`

```lua
{
  "sohanemon/cdx.yazi",
  lazy = true,
  build = function(plugin)
    require("yazi.plugin").build_plugin(plugin)
  end,
},
```

## Usage

Configure keymaps in your `~/.config/yazi/keymap.toml`. For example:

```toml
[manager]
prepend_keymap = [
  { on = ["g", "/"],       run = "cd $HOME",                           desc = "Go" },
  { on = ["g", "<space>"],  run = "cd --interactive",                   desc = "Interactive Go" },
  { on = ["g", "r"],        run = '''
    shell 'ya emit cd --str "$(git rev-parse --show-toplevel)"' --confirm
  ''', desc = "Git Root" },
  { on = ["g", "P"],        run = "cd ~/Pictures",                      desc = "Pictures" },
  { on = ["g", "V"],        run = "cd ~/Videos",                        desc = "Videos" },
  { on = ["g", "D"],        run = "cd ~/Documents",                     desc = "Documents" },
  { on = ["g", "d"],        run = "plugin cdx --args='~/Downloads'",      desc = "Downloads" },
  { on = ["g", "t"],        run = "plugin cdx --args='~/temp'",           desc = "Temporary" },
  { on = ["g", ".", "."],   run = "cd ~/dotfiles",                      desc = "Dotfiles" },
  { on = ["g", ".", "t"],   run = "cd ~/.tmp",                          desc = "Tmp" },
  { on = ["g", ".", "h"],   run = "cd ~/.config/hypr",                    desc = "Hyprland" },
  { on = ["g", ".", "y"],   run = "cd ~/.config/yazi",                    desc = "Yazi" },
  { on = ["g", ".", "n"],   run = "cd ~/.config/nvim",                    desc = "Neovim" },
  { on = ["g", ".", "c"],   run = "cd ~/.config/",                       desc = "Configs" },
  { on = ["g", "h"],        run = "plugin cdx --args='/'",                desc = "Home/Src" },
  { on = ["g", "s"],        run = "plugin cdx --args='/styles /style /css ~/Sync'", desc = "Styles" },
  { on = ["g", "u"],        run = "plugin cdx --args='/components/ui /components'", desc = "UI Components" },
  { on = ["g", "l"],        run = "plugin cdx --args='/lib /libs /utils'", desc = "Library" },
  { on = ["g", "p"],        run = "plugin cdx --args='/app/(index) /app/[locale] /app /pages /routes'", desc = "Pages" },
  { on = ["g", "a"],        run = "plugin cdx --args='/public/assets /public/images /public'", desc = "Assets" },
  { on = ["g", "C"],        run = "plugin cdx --args='~/Code'",         desc = "Code" },
  { on = ["g", "S"],        run = "plugin cdx --args='~/Sync'",         desc = "Syncthing" },
  { on = ["g", "c"],        run = "plugin cdx --args='/components ~/Code'", desc = "Components" }
]
```

The plugin automatically resolves and validates paths using its fallback strategies, notifying you if no valid path is found.

## Notes

- **Priority:** Uses `$NVIM_CWD` when available, falling back to the home directory or relative paths.
- **Base Path:** Defaults are set via `sohanscript.json`.
- **Extensibility:** Built to allow custom path handling.

## Configuration (Optional)

Create a `sohanscript.json` in your working directory to set defaults and fallbacks:

```json
{
  "$schema": "https://sohanjs.web.app/draft/next/schema.json",
  "packageManager": "bun",
  "cwd": "$NVIM_CWD/src",
  "directories": {
    "lib": "$NVIM_CWD/src/lib",
    "public": "$NVIM_CWD/public"
  }
}
```

This file lets you define a base directory, package manager, and custom directory mappings.
