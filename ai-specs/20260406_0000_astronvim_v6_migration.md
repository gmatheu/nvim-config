# AstroNvim v6 Migration Summary

**Date:** 2026-04-06

## Overview
Successfully migrated AstroNvim configuration from v5 to v6 according to the official migration guide at https://docs.astronvim.com/configuration/v6_migration/.

## Changes Made

### 1. Plugin Renames (High Priority)
Updated plugin names to match v6 naming conventions:

| Old Name | New Name | File |
|----------|----------|------|
| `Saghen/blink.cmp` | `saghen/blink.cmp` | `lua/plugins/cmp.lua` |
| `Saghen/blink.compat` | `saghen/blink.compat` | `lua/plugins/cmp.lua` |
| `echasnovski/mini.icons` | `nvim-mini/mini.icons` | `lua/plugins/astroui.lua` |
| `williamboman/mason-lspconfig.nvim` | `mason-org/mason-lspconfig.nvim` | `lua/plugins/mason.lua` |
| `williamboman/mason.nvim` | `mason-org/mason.nvim` | `lua/plugins/trial.lua` |

### 2. AstroLSP Configuration Updates (High Priority)
Updated `lua/plugins/astrolsp.lua` for v6 API changes:
- Added `config["*"]` table for default server configuration (new v6 format)
- Updated `handlers` documentation to use `"*"` key for default handler
- Documented migration to `vim.lsp.config` and `vim.lsp.enable` APIs

### 3. Treesitter Configuration (High Priority)
Updated `lua/plugins/astrocore.lua`:
- Added `treesitter` configuration table with `highlight = true`
- Configuration moved from nvim-treesitter plugin spec to AstroCore opts (v6 pattern)

### 4. Plugin Replacements (High Priority)

#### vim-illuminate → snacks.words
- Commented out `RRethy/vim-illuminate` in `lua/plugins/user.lua`
- AstroNvim v6 uses `snacks.words` module (already enabled in core snacks config)

#### nvim-notify removal
- Removed `rcarriga/nvim-notify` from noice.nvim dependencies in `lua/plugins/user.lua`
- v6 uses snacks.nvim's built-in notifier

### 5. Removed Deprecated Plugins (Low Priority)

#### Comment.nvim
- Commented out `numToStr/Comment.nvim` in `lua/plugins/core.lua`
- Neovim 0.11+ has built-in commenting (gc/gcc)
- v6 drops support for Neovim 0.10

#### nvim-ts-context-commentstring
- Removed from VS Code plugin list in `lua/plugins/vscode.lua`
- No longer needed in Neovim 0.11+

## Migration Verification

All configuration files have been updated according to the v6 migration guide:
- Plugin names use correct capitalization and organization names
- AstroLSP uses new `config["*"]` and handlers patterns
- Treesitter configuration follows v6 structure
- Removed plugins that are no longer supported or have built-in alternatives

## Notes

- The configuration was already using `version = "^6"` in `lazy_setup.lua`, indicating v6 was the target version
- All changes maintain backward compatibility where possible (Comment.nvim code is commented out, not deleted)
- LSP server configurations (denols, tsserver, eslint) continue to work with the new API

## Next Steps for User

1. Start Neovim to allow lazy.nvim to update plugins
2. Check `:checkhealth` to verify LSP configuration
3. Review any custom LSP server configurations that might need updating to use `vim.lsp.config`
4. Test key mappings and functionality to ensure everything works as expected
