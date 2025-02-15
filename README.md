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

1. [Absolute Paths]
```bash
:/YourPluginCommand "absolute/path/here"
```

2. [Relative Paths]
```bash
:/YourPluginCommand "relative/path/here"
```

3. [Environment Variable Paths]
```bash
:/YourPluginCommand "$NVIM_CWD/some/path"
```

The plugin will automatically resolve and validate the path using its fallback strategies. If no valid path is found, it will display a notification.

## Notes

- The plugin first tries to use $NVIM_CWD when available
- Falls back to home directory and relative paths
- Uses a configurable base path from `sohanscript.json`
- Built with extensibility in mind for custom path handling
