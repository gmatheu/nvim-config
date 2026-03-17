# Blink completion migration: nvim-cmp -> blink.cmp

## Request summary

Migrate AstroNvim completion configuration from a disabled `nvim-cmp` block to a fully functional `blink.cmp` setup while preserving existing key behavior and integrations.

Requested scope:
- Remove old disabled `nvim-cmp` override block in `lua/plugins/cmp.lua`
- Migrate completion source priorities to blink scoring
- Add cmdline completion support for search and command modes
- Keep existing `<Tab>` / `<S-Tab>` behavior, including AI accept and sidekick NES jump integration
- Enable Ecolog blink integration in `lua/plugins/trial.lua`
- Remove unneeded `nvim-cmp` dependency from `tabout.nvim` if possible
- Keep `import = "astrocommunity.recipes.ai"` unchanged

Important notes from request:
- `codeium` and `supermaven` are currently used via virtual text integrations (`neocodeium`, `supermaven-nvim`) rather than cmp sources
- Desired source priority mapping was based on previous nvim-cmp priorities

## Implementation summary

### 1) `lua/plugins/cmp.lua`

- Kept `import = "astrocommunity.recipes.ai"` unchanged.
- Expanded existing `Saghen/blink.cmp` spec instead of adding new plugin specs.
- Added dependency:
  - `Saghen/blink.compat`
- Preserved existing keymaps and AI/sidekick flow:
  - `<Tab>` chain still tries snippet forward -> `vim.g.ai_accept()` -> `require("sidekick").nes_jump_or_apply()` -> fallback
  - `<S-Tab>` still does snippet backward -> fallback
- Added source configuration under blink:
  - `default = { "snippets", "ecolog", "buffer", "lsp", "path" }`
  - `providers` score offsets aligned to requested priority intent:
    - `snippets`: `score_offset = 800` (Luasnip-equivalent snippet source in blink)
    - `ecolog`: `score_offset = 600` via `blink.compat.source`
    - `buffer`: `score_offset = 500`
    - `lsp`: `score_offset = 400`
    - `path`: `score_offset = 250`
- Added cmdline completion config for blink:
  - Enabled cmdline completion
  - `/` and `?` -> `buffer`
  - `:` -> `path`, `cmdline`, `buffer`
- Removed the legacy disabled `hrsh7th/nvim-cmp` override block entirely.

### 2) `lua/plugins/trial.lua`

- Updated Ecolog dependencies:
  - Replaced `hrsh7th/nvim-cmp` with `Saghen/blink.compat`
- Updated Ecolog integrations:
  - `blink_cmp = true` (was `false`)
  - left `nvim_cmp = true` as-is to avoid changing behavior beyond requested scope
- Updated `abecodes/tabout.nvim` dependencies:
  - Removed `hrsh7th/nvim-cmp`
  - Kept treesitter + LuaSnip dependencies

## Design decisions and rationale

- Used `blink.compat` specifically for Ecolog because Ecolog exposes a cmp-style source; this keeps source support while moving off `nvim-cmp`.
- Did not add `codeium`/`supermaven` blink providers because current setup uses virtual-text integrations instead of cmp source adapters.
- Used blink’s native `snippets` provider as the Luasnip equivalent and mapped priority intent through `score_offset`.
- Kept existing keymap semantics untouched to prevent workflow regressions.
