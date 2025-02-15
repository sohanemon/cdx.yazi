# cdx - change directory extended

A [Yazi](https://yazi-rs.github.io/) plugin that extends and improves directory navigation by providing smart path resolution and configuration support.

## Features

- Smart path resolution for absolute and relative paths
- Multiple path fallback strategies
- Configuration file support
- Integration with $NVIM_CWD (Requires [Yazi.nvim](https://github.com/mikavilpas/yazi.nvim))
- User notifications for invalid paths
- Extensible path handling

## Installation

```sh
git clone https://github.com/sohanemon/cdx.yazi ~/.config/yazi/plugins/cdx.yazi
```

Or Using `ya`
```sh
ya pack -a sohanemon/cdx
```

Using `lazy`
```lua
{
  "sohanemon/cdx.yazi",
  lazy = true,
  build = function(plugin)
    require("yazi.plugin").build_plugin(plugin)
  end,
},
```

## Configuration

You can configure the plugin behavior by creating a `sohanscript.json` file in the current working directory

Example configuration:
```json
{
  "$schema": "https://sohanjs.web.app/draft/next/schema.json",
  "packageManager": "bun",
  "cwd": "$NVIM_CWD/src",
  "directories": {
    "lib": "$NVIM_CWD/src/lib"
    "public": "$NVIM_CWD/public"
  },
}
```

The configuration allows you to define default paths and custom directory fallbacks.

## Usage

Add keymaps to your `~/.config/yazi/keymap.toml`. Here is some examples

```toml
[manager]
prepend_keymap = [
{ on = [
    "g",
    "/",
  ], run = "cd $HOME", desc = "Go" },
  { on = [
    "g",
    "<space>",
  ], run = "cd --interactive", desc = "Go" },
  { on = [
    "g",
    "r",
  ], run = '''
	shell 'ya emit cd --str "$(git rev-parse --show-toplevel)"' --confirm
''', desc = "Git Root" },
  { on = [
    "g",
    "P",
  ], run = "cd ~/Pictures", desc = "Pictures" },
  { on = [
    "g",
    "V",
  ], run = "cd ~/Videos", desc = "Videos" },
  { on = [
    "g",
    "D",
  ], run = "cd ~/Documents", desc = "Documents" },
  { on = [
    "g",
    "d",
  ], run = "plugin cdx --args='~/Downloads'", desc = "Downloads" },
  { on = [
    "g",
    "t",
  ], run = "plugin cdx --args='~/temp'", desc = "Temporary directory" },

  # Dotfiles
  { on = [
    "g",
    ".",
    ".",
  ], run = "cd ~/dotfiles", desc = "Dotfiles" },
  { on = [
    "g",
    ".",
    "t",
  ], run = "cd ~/.tmp", desc = "Temporary" },
  { on = [
    "g",
    ".",
    "h",
  ], run = "cd ~/.config/hypr", desc = "Hyprland" },
  { on = [
    "g",
    ".",
    "y",
  ], run = "cd ~/.config/yazi", desc = "Yazi" },
  { on = [
    "g",
    ".",
    "n",
  ], run = "cd ~/.config/nvim", desc = "Neovim" },
  { on = [
    "g",
    ".",
    "c",
  ], run = "cd ~/.config/", desc = "Configs" },

  # Goto Neovim
  { on = [
    "g",
    "h",
  ], run = "plugin cdx --args='/'", desc = "Home/Src" },
  { on = [
    "g",
    "s",
  ], run = "plugin cdx --args='/styles /style /css ~/Sync'", desc = "Styles" },
  { on = [
    "g",
    "u",
  ], run = "plugin cdx --args='/components/ui /components'", desc = "UI Components" },
  { on = [
    "g",
    "l",
  ], run = "plugin cdx --args='/lib /libs /utils'", desc = "Library" },
  { on = [
    "g",
    "p",
  ], run = "plugin cdx --args='/app/(index) /app/[locale] /app /pages /routes'", desc = "Pages" },
  { on = [
    "g",
    "a",
  ], run = "plugin cdx --args='/public/assets /public/images /public'", desc = "Assets" },
  { on = [
    "g",
    "C",
  ], run = "plugin cdx --args='~/Code'", desc = "Code" },
  { on = [
    "g",
    "S",
  ], run = "plugin cdx --args='~/Sync'", desc = "Syncthing" },
  { on = [
    "g",
    "c",
  ], run = "plugin cdx --args='/components ~/Code'", desc = "Components" },
]
```
The plugin will automatically resolve and validate the path using its fallback strategies. If no valid path is found, it will display a notification.

## Notes

- The plugin first tries to use $NVIM_CWD when available
- Falls back to home directory and relative paths
- Uses a configurable base path from `sohanscript.json`
- Built with extensibility in mind for custom path handling
