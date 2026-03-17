# Migration Guide: nvim-cmp to blink.cmp

**Date:** March 17, 2026  
**Version:** blink.cmp v1.10.1

## Overview

blink.cmp is a modern completion plugin for Neovim that offers better performance, built-in fuzzy matching, and native support for various snippet engines. This guide covers migrating from nvim-cmp with focus on practical configuration examples.

---

## 1. Source Mapping: nvim-cmp to blink.cmp

### Built-in Sources (Direct Equivalents)

| nvim-cmp Source | blink.cmp Source | Configuration |
|-----------------|------------------|---------------|
| `cmp.path` | `path` | Built-in |
| `cmp.lsp` | `lsp` | Built-in |
| `cmp.buffer` | `buffer` | Built-in |
| `cmp.snippy` / `cmp_luasnip` | `snippets` | Built-in (preset: `luasnip`) |
| `cmp.cmdline` | `cmdline` | Built-in |
| `cmp.omni` | `omni` | Built-in |

### External Sources

| nvim-cmp Source | blink.cmp Solution | Notes |
|-----------------|--------------------|-------|
| `cmp-codeium` | `blink-cmp-codeium` (community) | Use `codeium.nvim` with blink.cmp integration |
| `cmp-ecolog` | `ecolog.nvim` + blink.compat | Use blink.compat wrapper |
| `cmp-supermaven` | `blink-cmp-supermaven` | Community source available |
| `cmp-copilot` | `blink-copilot` | Dedicated blink.cmp source |
| Other custom sources | `blink.compat` | Compatibility layer |

### Basic Source Configuration

```lua
-- blink.cmp configuration
{
  'saghen/blink.cmp',
  version = '1.*',
  opts = {
    sources = {
      -- Default sources (order matters for priority)
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      
      -- Per-filetype configuration
      per_filetype = {
        lua = { 'lsp', 'path', 'snippets', 'buffer' },
        sql = { 'lsp', 'dadbod', 'path', 'buffer' },
      },
      
      -- Provider-specific configuration
      providers = {
        lsp = {
          name = 'LSP',
          module = 'blink.cmp.sources.lsp',
          score_offset = 0,
          fallbacks = { 'buffer' },
        },
        path = {
          score_offset = 3,  -- Boost path completions
          fallbacks = { 'buffer' },
        },
        buffer = {
          score_offset = -3,  -- Deprioritize buffer completions
        },
        snippets = {
          score_offset = -1,
        },
      },
    },
  },
}
```

---

## 2. Configuration Structure and Key Differences

### nvim-cmp vs blink.cmp Structure

**nvim-cmp (traditional):**
```lua
require('cmp').setup({
  sources = cmp.config.sources({
    { name = 'lsp' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  mapping = cmp.mapping.preset.insert({}),
  -- ... many other options
})
```

**blink.cmp (modular):**
```lua
{
  'saghen/blink.cmp',
  opts = {
    -- Keymaps
    keymap = { preset = 'default' },
    
    -- Completion behavior
    completion = {
      keyword = { range = 'prefix' },
      trigger = { show_on_trigger_character = true },
      list = { max_items = 200, selection = { preselect = true, auto_insert = true } },
      menu = { auto_show = true },
    },
    
    -- Fuzzy matching
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    
    -- Sources
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    
    -- Snippets
    snippets = { preset = 'default' },  -- or 'luasnip', 'mini_snippets', 'vsnip'
    
    -- Appearance
    appearance = { kind_icons = {...} },
  },
}
```

### Key Differences

1. **No Manual LSP Configuration Required**: blink.cmp automatically handles LSP capabilities
2. **Built-in Fuzzy Matching**: Rust-based (frizbee) with typo resistance
3. **Frecency & Proximity**: Automatically boosts frequently used items
4. **Simpler Source Configuration**: Sources defined in flat table with priorities

### Complete Minimal Configuration

```lua
{
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'rafamadriz/friendly-snippets',  -- Optional but recommended
  },
  opts = {
    -- Keymap preset: 'default', 'cmdline', or custom
    keymap = { preset = 'default' },
    
    -- Completion sources
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    
    -- Snippet engine (default uses vim.snippet)
    snippets = { preset = 'default' },
    
    -- Fuzzy matching (optional - uses Rust by default)
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    
    -- Appearance
    appearance = {
      nerd_font_variant = 'mono',
    },
  },
}
```

---

## 3. Cmdline Completion Configuration

### Basic Cmdline Setup

```lua
{
  'saghen/blink.cmp',
  opts = {
    cmdline = {
      enabled = true,
      keymap = { preset = 'cmdline' },
      sources = { 'buffer', 'cmdline' },
      
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = { 
          auto_show = function(ctx, _) 
            return ctx.mode == 'cmdwin' 
          end 
        },
        ghost_text = { enabled = true },
      },
    },
  },
}
```

### Advanced Cmdline Source Filtering

```lua
cmdline = {
  enabled = true,
  sources = function()
    local type = vim.fn.getcmdtype()
    
    -- Search forward/backward (/)
    if type == '/' or type == '?' then 
      return { 'buffer' } 
    end
    
    -- Commands (:)
    if type == ':' then 
      return { 'cmdline', 'buffer' } 
    end
    
    -- Expression register (@)
    if type == '@' then 
      return { 'cmdline', 'buffer' } 
    end
    
    return {}
  end,
}
```

### Terminal Completion (Neovim 0.11+)

```lua
term = {
  enabled = true,  -- Only on Neovim 0.11+
  keymap = { preset = 'inherit' },
  sources = { 'buffer' },
}
```

---

## 4. Priority/Score Offset Settings

### Understanding Score Offset

The `score_offset` parameter boosts or penalizes items from a source:

- **Positive values**: Boost priority (appear higher in list)
- **Negative values**: Deprioritize (appear lower in list)
- **Default values**: LSP=0, path=3, snippets=-1, buffer=-3

### Practical Examples

```lua
sources = {
  providers = {
    -- LSP completions first
    lsp = {
      score_offset = 0,
    },
    
    -- Path completions higher
    path = {
      score_offset = 3,
    },
    
    -- Snippets lower
    snippets = {
      score_offset = -1,
    },
    
    -- Buffer words lowest by default
    buffer = {
      score_offset = -3,
    },
  },
}
```

### Context-Aware Score Adjustment

```lua
sources = {
  providers = {
    lsp = {
      -- Dynamic score based on trigger kind
      score_offset = function(ctx)
        -- Boost LSP when triggered by character
        if ctx.trigger.kind == 'trigger_character' then
          return 5
        end
        return 0
      end,
    },
  },
}
```

### Per-Filetype Priority

```lua
sources = {
  per_filetype = {
    -- In Lua files, boost LSP even more
    lua = { 
      inherit_defaults = true,
      providers = {
        lsp = { score_offset = 5 },
      },
    },
    
    -- In Markdown, only use buffer
    markdown = { 'buffer' },
  },
}
```

---

## 5. Migration Patterns and Best Practices

### Using blink.compat for nvim-cmp Sources

For nvim-cmp sources without blink.cmp equivalents:

```lua
-- Add blink.compat dependency
{
  'saghen/blink.compat',
  version = '2.*',
  lazy = true,
  opts = {},
},

-- Configure nvim-cmp source
{
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    { 'some/cmp-source' },  -- Original nvim-cmp source
  },
  opts = {
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'my_source' },
      providers = {
        my_source = {
          name = 'my_source',  -- Must match nvim-cmp source name
          module = 'blink.compat.source',
          score_offset = -3,
          opts = {
            -- Options passed to nvim-cmp source
          },
        },
      },
    },
  },
}
```

### Snippet Engine Migration

**Using vim.snippet (default):**
```lua
snippets = { preset = 'default' }
```

**Using LuaSnip:**
```lua
{
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  opts = {
    snippets = { preset = 'luasnip' },
  },
}
```

**Using mini.snippets:**
```lua
{
  'saghen/blink.cmp',
  dependencies = 'echasnovski/mini.snippets',
  opts = {
    snippets = { preset = 'mini_snippets' },
  },
}
```

### Keymap Migration

```lua
keymap = {
  preset = 'default',  -- 'default', 'cmdline', or custom
  
  -- Or custom keybindings
  ['<Tab>'] = { 'snippet_forward', 'fallback' },
  ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  ['<C-n>'] = { 'select_next', 'fallback' },
  ['<C-p>'] = { 'select_prev', 'fallback' },
  ['<C-y>'] = { 'confirm', 'fallback' },
  ['<C-e>'] = { 'cancel', 'fallback' },
}
```

### LSP Capabilities

```lua
-- In lspconfig setup
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Or with overrides
local capabilities = require('blink.cmp').get_lsp_capabilities({
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = false,
      },
    },
  },
})

require('lspconfig').rust_analyzer.setup({
  capabilities = capabilities,
})
```

---

## 6. Community Sources for AI Completion

### Codeium

```lua
-- Using codeium.nvim with virtual text disabled
{
  'Exafunction/codeium.nvim',
  cmd = 'Codeium',
  event = 'InsertEnter',
  build = ':Codeium Auth',
  opts = {
    virtual_text = {
      key_bindings = {
        accept = false,  -- Handled by completion engine
      },
    },
  },
}
```

### Supermaven

```lua
-- Using supermaven-nvim with blink.cmp integration
{
  'supermaven-inc/supermaven-nvim',
  event = 'InsertEnter',
  cmd = { 'SupermavenUseFree', 'SupermavenUsePro' },
  opts = {
    keymaps = {
      accept_suggestion = nil,  -- Handled by blink.cmp
    },
  },
}

-- Or use community source
{
  'Huijiro/blink-cmp-supermaven',
  dependencies = { 'saghen/blink.cmp' },
}
```

### GitHub Copilot

```lua
-- Using blink-copilot
{
  'fang2hou/blink-copilot',
  opts = {
    max_completions = 1,
    max_attempts = 2,
  },
}
```

### Ecolog (Environment Variables)

```lua
-- Using ecolog.nvim with blink.compat
{
  'ph1losof/ecolog.nvim',
  opts = {
    -- Configuration
  },
}

-- Add to blink.cmp via blink.compat
-- (ecolog.nvim may have native blink.cmp support)
```

---

## 7. Common Recipes

### Disable Completion for Specific Filetypes

```lua
enabled = function()
  return not vim.tbl_contains({ 'lua', 'markdown' }, vim.bo.filetype)
end,

-- Or per-buffer
vim.b.completion = false
```

### Auto-show Documentation

```lua
completion = {
  documentation = {
    auto_show = true,
    auto_show_delay_ms = 500,
  },
}
```

### Ghost Text for AI Completions

```lua
completion = {
  ghost_text = {
    enabled = true,
    show_with_selection = true,
    show_without_selection = false,
  },
}
```

### Custom Menu Columns

```lua
completion = {
  menu = {
    draw = {
      columns = {
        { 'kind_icon' },
        { 'label', 'label_description', gap = 1 },
        { 'kind' },
      },
    },
  },
}
```

---

## 8. Resources

- **Official Docs**: https://cmp.saghen.dev
- **GitHub**: https://github.com/saghen/blink.cmp
- **blink.compat**: https://github.com/saghen/blink.compat
- **Community Sources**: https://cmp.saghen.dev/configuration/sources#community-sources
- **Recipes**: https://cmp.saghen.dev/recipes

---

## 9. Migration Checklist

- [ ] Install blink.cmp with `version = '1.*'`
- [ ] Replace nvim-cmp sources with blink.cmp equivalents
- [ ] Configure keymap (use preset or custom)
- [ ] Set up snippet engine (default or LuaSnip/mini.snippets)
- [ ] Configure cmdline completion if needed
- [ ] Adjust score_offset for priority
- [ ] Test AI completion integration (Codeium/Supermaven/Copilot)
- [ ] Remove nvim-cmp and related plugins
- [ ] Verify LSP capabilities are working
